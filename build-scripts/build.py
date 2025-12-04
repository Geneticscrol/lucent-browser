#!/usr/bin/env python3
"""
Lucent Browser - Build Script
Compiles the browser from source
"""

import os
import sys
import subprocess
import time
from pathlib import Path
from datetime import datetime, timedelta

class Colors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'

def print_header(message):
    print(f"\n{Colors.HEADER}{Colors.BOLD}{'='*60}{Colors.ENDC}")
    print(f"{Colors.HEADER}{Colors.BOLD}{message}{Colors.ENDC}")
    print(f"{Colors.HEADER}{Colors.BOLD}{'='*60}{Colors.ENDC}\n")

def print_success(message):
    print(f"{Colors.OKGREEN}✓ {message}{Colors.ENDC}")

def print_error(message):
    print(f"{Colors.FAIL}✗ {message}{Colors.ENDC}")

def print_info(message):
    print(f"{Colors.OKCYAN}ℹ {message}{Colors.ENDC}")

def print_warning(message):
    print(f"{Colors.WARNING}⚠ {message}{Colors.ENDC}")

def build_browser():
    """Build Lucent Browser"""
    print_header("Building Lucent Browser")
    
    project_root = Path(__file__).parent.parent
    firefox_dir = project_root / "firefox-source"
    
    if not firefox_dir.exists():
        print_error("Firefox source not found!")
        print_info("Please run setup.py first.")
        return False
    
    # Check for mozconfig
    mozconfig = firefox_dir / "mozconfig"
    if not mozconfig.exists():
        print_error("mozconfig not found!")
        return False
    
    print_info("Starting build process...")
    print_warning("This will take 1-2 hours depending on your hardware.")
    print_info("You can safely minimize this window and do other work.")
    
    start_time = time.time()
    
    # Build command
    build_cmd = "./mach build"
    
    if sys.platform == "win32":
        print_info("On Windows, run this in MozillaBuild shell:")
        print_info(f"  cd {firefox_dir}")
        print_info(f"  {build_cmd}")
        print_warning("Cannot automate build on Windows. Please run manually.")
        return True
    
    try:
        print_info("Executing: ./mach build")
        process = subprocess.Popen(
            ["./mach", "build"],
            cwd=firefox_dir,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            universal_newlines=True,
            bufsize=1
        )
        
        # Stream output
        for line in process.stdout:
            print(line, end='')
        
        process.wait()
        
        if process.returncode == 0:
            elapsed = time.time() - start_time
            elapsed_str = str(timedelta(seconds=int(elapsed)))
            print_success(f"\nBuild completed successfully in {elapsed_str}!")
            return True
        else:
            print_error(f"\nBuild failed with exit code {process.returncode}")
            return False
            
    except Exception as e:
        print_error(f"Build failed: {e}")
        return False

def package_browser():
    """Create distribution package"""
    print_header("Packaging Lucent Browser")
    
    project_root = Path(__file__).parent.parent
    firefox_dir = project_root / "firefox-source"
    
    if sys.platform == "win32":
        print_info("To package on Windows, run in MozillaBuild shell:")
        print_info("  ./mach package")
        return True
    
    print_info("Creating package...")
    
    try:
        result = subprocess.run(
            ["./mach", "package"],
            cwd=firefox_dir,
            check=True,
            capture_output=True,
            text=True
        )
        
        print_success("Package created successfully")
        print_info("Package location: obj-lucent/dist/")
        return True
        
    except subprocess.CalledProcessError as e:
        print_error(f"Packaging failed: {e}")
        return False

def main():
    print_header("Lucent Browser Build System")
    
    print_info("What would you like to do?")
    print("  1. Build browser")
    print("  2. Build and package")
    print("  3. Clean build (remove obj-lucent)")
    
    choice = input("\nEnter choice (1-3): ").strip()
    
    if choice == "1":
        if build_browser():
            print_header("Build Complete!")
            print_success("Lucent Browser has been built successfully.")
            print_info("Run: python build-scripts/run.py to launch it")
    
    elif choice == "2":
        if build_browser() and package_browser():
            print_header("Build and Package Complete!")
            print_success("Lucent Browser is ready for distribution.")
    
    elif choice == "3":
        print_warning("This will delete the build directory.")
        confirm = input("Are you sure? (yes/no): ").strip().lower()
        if confirm == "yes":
            project_root = Path(__file__).parent.parent
            obj_dir = project_root / "firefox-source" / "obj-lucent"
            if obj_dir.exists():
                import shutil
                shutil.rmtree(obj_dir)
                print_success("Build directory cleaned")
            else:
                print_info("Build directory doesn't exist")
    
    else:
        print_error("Invalid choice")

if __name__ == "__main__":
    main()

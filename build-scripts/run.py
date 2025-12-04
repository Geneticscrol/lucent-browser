#!/usr/bin/env python3
"""
Lucent Browser - Run Script
Launches the built browser
"""

import os
import sys
import subprocess
from pathlib import Path

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

def setup_profile():
    """Set up a profile with Lucent customizations"""
    project_root = Path(__file__).parent.parent
    profile_dir = project_root / "lucent-profile"
    
    if not profile_dir.exists():
        profile_dir.mkdir(parents=True)
        print_info("Created profile directory")
    
    # Copy user.js
    user_js_src = project_root / "configs" / "user.js"
    user_js_dst = profile_dir / "user.js"
    
    if user_js_src.exists():
        import shutil
        shutil.copy(user_js_src, user_js_dst)
        print_success("Copied privacy configuration")
    
    # Create chrome directory for CSS
    chrome_dir = profile_dir / "chrome"
    if not chrome_dir.exists():
        chrome_dir.mkdir()
    
    # Copy userChrome.css
    user_chrome_src = project_root / "chrome" / "userChrome.css"
    user_chrome_dst = chrome_dir / "userChrome.css"
    
    if user_chrome_src.exists():
        import shutil
        shutil.copy(user_chrome_src, user_chrome_dst)
        print_success("Copied UI transparency styles")
    
    # Copy userContent.css
    user_content_src = project_root / "chrome" / "userContent.css"
    user_content_dst = chrome_dir / "userContent.css"
    
    if user_content_src.exists():
        import shutil
        shutil.copy(user_content_src, user_content_dst)
        print_success("Copied content transparency styles")
    
    return profile_dir

def run_browser():
    """Launch Lucent Browser"""
    print_header("Launching Lucent Browser")
    
    project_root = Path(__file__).parent.parent
    firefox_dir = project_root / "firefox-source"
    obj_dir = firefox_dir / "obj-lucent"
    
    if not obj_dir.exists():
        print_error("Build directory not found!")
        print_info("Please run build.py first.")
        return False
    
    # Setup profile
    profile_dir = setup_profile()
    
    # Find the browser executable
    if sys.platform == "win32":
        browser_exe = obj_dir / "dist" / "bin" / "firefox.exe"
    elif sys.platform == "darwin":
        browser_exe = obj_dir / "dist" / "Lucent.app" / "Contents" / "MacOS" / "firefox"
    else:  # Linux
        browser_exe = obj_dir / "dist" / "bin" / "firefox"
    
    if not browser_exe.exists():
        print_error(f"Browser executable not found at {browser_exe}")
        print_info("Build may have failed or is incomplete.")
        
        # Try using mach run instead
        print_info("Attempting to run with ./mach run...")
        try:
            subprocess.run(
                ["./mach", "run", "--profile", str(profile_dir)],
                cwd=firefox_dir,
                check=True
            )
            return True
        except:
            return False
    
    print_success(f"Found browser at: {browser_exe}")
    print_info(f"Using profile: {profile_dir}")
    print_info("Starting Lucent Browser...")
    
    try:
        # Launch browser
        cmd = [
            str(browser_exe),
            "--profile", str(profile_dir),
            "--no-remote"
        ]
        
        subprocess.Popen(cmd)
        print_success("Lucent Browser launched!")
        print_info("Enjoy your translucent browsing experience! 🌟")
        return True
        
    except Exception as e:
        print_error(f"Failed to launch browser: {e}")
        return False

def main():
    print_header("Lucent Browser Launcher")
    
    if not run_browser():
        print_error("\nFailed to launch browser.")
        print_info("Make sure you have built it first: python build-scripts/build.py")
        sys.exit(1)

if __name__ == "__main__":
    main()

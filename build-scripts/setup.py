#!/usr/bin/env python3
"""
Lucent Browser - Setup Script
Downloads Firefox source code and prepares the build environment
"""

import os
import sys
import subprocess
import urllib.request
import shutil
from pathlib import Path

# Configuration
FIREFOX_VERSION = "115.6.0esr"  # Use ESR for stability
FIREFOX_SOURCE_URL = f"https://archive.mozilla.org/pub/firefox/releases/{FIREFOX_VERSION}/source/firefox-{FIREFOX_VERSION}.source.tar.xz"
MERCURIAL_REPO = "https://hg.mozilla.org/releases/mozilla-esr115"

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

def run_command(cmd, cwd=None):
    """Run a shell command and return the result"""
    try:
        result = subprocess.run(cmd, shell=True, check=True, cwd=cwd, 
                              capture_output=True, text=True)
        return result.returncode == 0
    except subprocess.CalledProcessError as e:
        print_error(f"Command failed: {cmd}")
        print(e.stderr)
        return False

def check_dependencies():
    """Check if required dependencies are installed"""
    print_header("Checking Dependencies")
    
    dependencies = {
        'python3': 'Python 3',
        'git': 'Git',
        'rustc': 'Rust',
        'cargo': 'Cargo',
    }
    
    missing = []
    for cmd, name in dependencies.items():
        if shutil.which(cmd):
            print_success(f"{name} is installed")
        else:
            print_error(f"{name} is NOT installed")
            missing.append(name)
    
    if missing:
        print_error(f"\nMissing dependencies: {', '.join(missing)}")
        print_info("Please install missing dependencies before continuing.")
        
        if sys.platform == "win32":
            print_info("\nFor Windows, install:")
            print_info("  1. Visual Studio 2022 (Community Edition)")
            print_info("  2. Rust: https://rustup.rs")
            print_info("  3. Git: https://git-scm.com")
            print_info("  4. MozillaBuild: https://ftp.mozilla.org/pub/mozilla/libraries/win32/MozillaBuildSetup-Latest.exe")
        elif sys.platform == "linux":
            print_info("\nFor Ubuntu/Debian:")
            print_info("  sudo apt install python3 git rustc cargo")
            print_info("  ./mach bootstrap")
        elif sys.platform == "darwin":
            print_info("\nFor macOS:")
            print_info("  Install Xcode Command Line Tools")
            print_info("  brew install python rust")
        
        return False
    
    return True

def download_firefox_source():
    """Download Firefox source code"""
    print_header("Downloading Firefox Source Code")
    
    project_root = Path(__file__).parent.parent
    firefox_dir = project_root / "firefox-source"
    
    if firefox_dir.exists():
        print_info(f"Firefox source already exists at {firefox_dir}")
        response = input("Download fresh copy? (y/N): ")
        if response.lower() != 'y':
            return True
        shutil.rmtree(firefox_dir)
    
    print_info(f"Cloning Firefox ESR repository...")
    print_info("This will take some time (several GB)...")
    
    # Use mercurial if available, otherwise download tarball
    if shutil.which('hg'):
        cmd = f"hg clone {MERCURIAL_REPO} {firefox_dir}"
        if run_command(cmd):
            print_success("Firefox source cloned successfully")
            return True
    else:
        print_info("Mercurial not found, downloading tarball instead...")
        print_info("Note: For development, consider installing Mercurial (hg)")
        
        tarball = project_root / f"firefox-{FIREFOX_VERSION}.source.tar.xz"
        
        print_info(f"Downloading {FIREFOX_SOURCE_URL}...")
        try:
            urllib.request.urlretrieve(FIREFOX_SOURCE_URL, tarball)
            print_success("Download complete")
            
            print_info("Extracting source code...")
            shutil.unpack_archive(tarball, firefox_dir)
            tarball.unlink()  # Delete tarball
            
            print_success("Source code extracted")
            return True
        except Exception as e:
            print_error(f"Download failed: {e}")
            return False
    
    return False

def setup_build_environment():
    """Set up the build environment"""
    print_header("Setting Up Build Environment")
    
    project_root = Path(__file__).parent.parent
    firefox_dir = project_root / "firefox-source"
    
    if not firefox_dir.exists():
        print_error("Firefox source not found. Run download step first.")
        return False
    
    # Copy mozconfig
    print_info("Copying mozconfig...")
    mozconfig_src = project_root / "configs" / "mozconfig"
    mozconfig_dst = firefox_dir / "mozconfig"
    shutil.copy(mozconfig_src, mozconfig_dst)
    print_success("mozconfig copied")
    
    # Create branding directory
    print_info("Setting up Lucent branding...")
    branding_src = project_root / "branding"
    branding_dst = firefox_dir / "browser" / "branding" / "lucent"
    
    if branding_dst.exists():
        shutil.rmtree(branding_dst)
    
    # For now, we'll use the default Firefox branding
    # In production, you would copy custom branding files here
    print_info("Using default Firefox branding (customize later)")
    
    # Bootstrap the build environment
    print_info("Bootstrapping build environment...")
    print_info("This will install additional dependencies...")
    
    if sys.platform == "win32":
        print_info("Run this in MozillaBuild shell: ./mach bootstrap")
    else:
        bootstrap_cmd = "./mach bootstrap --application-choice=browser --no-interactive"
        if run_command(bootstrap_cmd, cwd=firefox_dir):
            print_success("Build environment bootstrapped")
        else:
            print_error("Bootstrap failed")
            return False
    
    print_success("Build environment setup complete")
    return True

def apply_patches():
    """Apply Lucent-specific patches"""
    print_header("Applying Lucent Patches")
    
    project_root = Path(__file__).parent.parent
    patches_dir = project_root / "patches"
    firefox_dir = project_root / "firefox-source"
    
    if not patches_dir.exists():
        print_info("No patches directory found, skipping...")
        return True
    
    patches = list(patches_dir.glob("*.patch"))
    
    if not patches:
        print_info("No patches found, skipping...")
        return True
    
    for patch in patches:
        print_info(f"Applying {patch.name}...")
        cmd = f"git apply {patch}"
        if run_command(cmd, cwd=firefox_dir):
            print_success(f"Applied {patch.name}")
        else:
            print_error(f"Failed to apply {patch.name}")
            return False
    
    print_success("All patches applied")
    return True

def main():
    print_header("Lucent Browser Setup")
    print_info("This script will prepare your environment for building Lucent Browser")
    
    # Check dependencies
    if not check_dependencies():
        print_error("\nSetup cannot continue due to missing dependencies.")
        sys.exit(1)
    
    # Download Firefox source
    if not download_firefox_source():
        print_error("\nFailed to download Firefox source code.")
        sys.exit(1)
    
    # Setup build environment
    if not setup_build_environment():
        print_error("\nFailed to setup build environment.")
        sys.exit(1)
    
    # Apply patches
    if not apply_patches():
        print_error("\nFailed to apply patches.")
        sys.exit(1)
    
    print_header("Setup Complete!")
    print_success("Your build environment is ready.")
    print_info("\nNext steps:")
    print_info("  1. Run: python build-scripts/build.py")
    print_info("  2. Wait for compilation (this takes 1-2 hours)")
    print_info("  3. Run: python build-scripts/run.py")
    print_info("\nHappy building! 🚀")

if __name__ == "__main__":
    main()

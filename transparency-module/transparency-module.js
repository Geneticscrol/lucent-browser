// Lucent Browser - Windows Transparency Module
// Uses Windows API to enable window-level transparency

const ffi = require('ffi-napi');
const ref = require('ref-napi');

// Windows API constants
const GWL_EXSTYLE = -20;
const WS_EX_LAYERED = 0x00080000;
const LWA_ALPHA = 0x00000002;

// Load Windows DLLs
const user32 = ffi.Library('user32', {
  'FindWindowA': ['long', ['string', 'string']],
  'GetWindowLongA': ['long', ['long', 'int']],
  'SetWindowLongA': ['long', ['long', 'int', 'long']],
  'SetLayeredWindowAttributes': ['bool', ['long', 'int', 'byte', 'int']],
  'EnumWindows': ['bool', ['pointer', 'int']],
  'GetWindowTextA': ['int', ['long', 'pointer', 'int']],
  'IsWindowVisible': ['bool', ['long']],
  'DwmEnableBlurBehindWindow': ['int', ['long', 'pointer']],
  'DwmExtendFrameIntoClientArea': ['int', ['long', 'pointer']]
});

const dwmapi = ffi.Library('dwmapi', {
  'DwmEnableBlurBehindWindow': ['int', ['long', 'pointer']],
  'DwmExtendFrameIntoClientArea': ['int', ['long', 'pointer']],
  'DwmSetWindowAttribute': ['int', ['long', 'int', 'pointer', 'int']]
});

function findFirefoxWindow() {
  let firefoxHwnd = null;
  
  // Callback for EnumWindows
  const callback = ffi.Callback('bool', ['long', 'int'], (hwnd, lParam) => {
    if (user32.IsWindowVisible(hwnd)) {
      const buffer = Buffer.alloc(256);
      const length = user32.GetWindowTextA(hwnd, buffer, 256);
      const title = buffer.toString('utf8', 0, length);
      
      // Look for Firefox windows
      if (title.includes('Firefox') || title.includes('Mozilla')) {
        console.log(`Found window: ${title} (HWND: ${hwnd})`);
        firefoxHwnd = hwnd;
        return false; // Stop enumeration
      }
    }
    return true; // Continue enumeration
  });
  
  user32.EnumWindows(callback, 0);
  return firefoxHwnd;
}

function enableTransparency(hwnd, opacity = 217) { // 85% opacity = 217/255
  try {
    // Get current extended style
    const exStyle = user32.GetWindowLongA(hwnd, GWL_EXSTYLE);
    
    // Add layered window style
    const newExStyle = exStyle | WS_EX_LAYERED;
    user32.SetWindowLongA(hwnd, GWL_EXSTYLE, newExStyle);
    
    // Set window transparency
    const result = user32.SetLayeredWindowAttributes(hwnd, 0, opacity, LWA_ALPHA);
    
    if (result) {
      console.log(`✓ Transparency enabled (opacity: ${Math.round(opacity/255*100)}%)`);
      return true;
    } else {
      console.log('✗ Failed to set transparency');
      return false;
    }
  } catch (error) {
    console.error('Error enabling transparency:', error);
    return false;
  }
}

function enableAcrylicBlur(hwnd) {
  try {
    // Windows 11 Acrylic effect
    const DWM_SYSTEMBACKDROP_TYPE = 38;
    const DWMSBT_TRANSIENTWINDOW = 3; // Acrylic blur
    
    const backdropType = ref.alloc('int', DWMSBT_TRANSIENTWINDOW);
    const result = dwmapi.DwmSetWindowAttribute(
      hwnd,
      DWM_SYSTEMBACKDROP_TYPE,
      backdropType,
      4
    );
    
    if (result === 0) {
      console.log('✓ Acrylic blur enabled (Windows 11)');
      return true;
    } else {
      console.log('⚠ Acrylic blur not available (Windows 10 or older)');
      return false;
    }
  } catch (error) {
    console.error('Error enabling acrylic:', error);
    return false;
  }
}

// Main execution
console.log('🪟 Lucent Browser - Transparency Enabler');
console.log('='.repeat(50));
console.log('');
console.log('Searching for Firefox windows...');

const hwnd = findFirefoxWindow();

if (hwnd) {
  console.log('');
  console.log('Applying transparency...');
  
  // Enable transparency
  enableTransparency(hwnd, 217); // 85% opacity
  
  // Try to enable acrylic blur (Windows 11)
  enableAcrylicBlur(hwnd);
  
  console.log('');
  console.log('✨ Done! Your browser should now be transparent.');
  console.log('');
  console.log('💡 Tip: Run this script each time you start the browser');
  console.log('   or use the provided watcher script.');
} else {
  console.log('');
  console.log('✗ No Firefox window found!');
  console.log('');
  console.log('Make sure Firefox is running, then try again.');
}

module.exports = { enableTransparency, enableAcrylicBlur, findFirefoxWindow };

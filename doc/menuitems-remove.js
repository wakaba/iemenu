var wsh = WScript.CreateObject ('WScript.Shell');
wsh.RegDelete ('HKCU\\Software\\Microsoft\\Internet Explorer\\MenuExt\\Open description\\');
wsh.RegDelete ('HKCU\\Software\\Microsoft\\Internet Explorer\\MenuExt\\Open description in new window\\');
wsh.RegDelete ('HKCU\\Software\\Microsoft\\Internet Explorer\\MenuExt\\Show list of anchors\\');
wsh.RegDelete ('HKCU\\Software\\Microsoft\\Internet Explorer\\MenuExt\\Show comments\\');
wsh.RegDelete ('HKCU\\Software\\Microsoft\\Internet Explorer\\MenuExt\\Show <head> information\\');
wsh.RegDelete ('HKCU\\Software\\Microsoft\\Internet Explorer\\MenuExt\\Show list of headings\\');
wsh.RegDelete ('HKCU\\Software\\Microsoft\\Internet Explorer\\MenuExt\\Show relative URIs\\');
wsh.RegDelete ('HKCU\\Software\\Microsoft\\Internet Explorer\\MenuExt\\Enable URI tooltip\\');

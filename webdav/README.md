# Setting up Webdav

Cannot connect to WebDAV Directory
If you can not connect to WebDAV Directory then the “Value data” of Basic Authentication Level is not set to 2. Which it should be, otherwise, you will see the error.

So, we will be altering a registry policy “BasicAuthLevel” and fix the error. So, launch Registry Editor from the Start Menu and navigate to the following location.

HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WebClient\Parameters
Double-click on BasicAuthLevel, set the Value data to 2, and click Ok.

Hopefully, now you know what is WebDAV and how you can map it in Windows 10.

Related: Cyberduck is a free WebDAV client for Windows PC.

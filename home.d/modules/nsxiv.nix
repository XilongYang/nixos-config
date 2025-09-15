{ config, ... }:
{
  home.file.".local/share/applications/nsxiv.desktop".text = ''
    [Desktop Entry]
    Name=nsxiv
    Comment=Simple X Image Viewer (fork of sxiv)
    Exec=nsxiv %f
    Terminal=false
    Type=Application
    Categories=Graphics;Viewer;
    MimeType=image/png;image/jpeg;image/gif;image/webp;image/bmp;image/tiff;image/svg+xml;
    Icon=image-viewer
  '';
}


//
//  main.m
//  tihmstarInstaller
//
//  Created by Brandon Plank on 12/30/19.
//  Copyright © 2019 Brandon Plank. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <pwd.h>
#include <spawn.h>

void InstallTihmstarDepends(char *name_of_file) {
    NSString *command = @"brew install ";
    command = [command stringByAppendingString:[NSString stringWithFormat:@"%s", name_of_file]];
    system([command UTF8String]);
}

void InstallDepends(char *name_of_file) {
    InstallTihmstarDepends(name_of_file);
    printf("Done!\n");
}


void gitCloneRec(char *gitaddress){
    NSString *command = @"cd ~/Desktop/TihmstarSoftware; git clone --recursive ";
    command = [command stringByAppendingString:[NSString stringWithFormat:@"%s", gitaddress]];
    system([command UTF8String]);
}

void initFolerAndCD(){
    NSString *command = @"mkdir ~/Desktop/TihmstarSoftware; cd  ~/Desktop/TihmstarSoftware";
    system([command UTF8String]);
}

void cdAndCompile(char *where){
    NSString *command = @"cd ";
    command = [command stringByAppendingString:[NSString stringWithFormat:@"~/Desktop/TihmstarSoftware/%s; ", where]];
    command = [command stringByAppendingString:[NSString stringWithFormat:@"export PKG_CONFIG_PATH=\"/usr/local/opt/openssl@1.1/lib/pkgconfig\"; "]];
    command = [command stringByAppendingString:[NSString stringWithFormat:@"./autogen.sh; "]];
    command = [command stringByAppendingString:[NSString stringWithFormat:@"make; "]];
    command = [command stringByAppendingString:[NSString stringWithFormat:@"sudo make install; "]];
    command = [command stringByAppendingString:[NSString stringWithFormat:@"cd ../; "]];
    system([command UTF8String]);
}



int main() {
    @autoreleasepool {
        printf("===========================================\n");
        printf("Tihmstar depends installer by Brandon Plank\n");
        printf("===========================================\n");
        printf("Installing! Please Wait!\n");
        InstallDepends("ack");
        InstallDepends("atk");
        InstallDepends("autoconf");
        InstallDepends("automake");
        InstallDepends("binutils");
        InstallDepends("binwalk");
        InstallDepends("boost");
        InstallDepends("cairo");
        InstallDepends("cifer");
        InstallDepends("clutter");
        InstallDepends("cmake");
        InstallDepends("cogl");
        InstallDepends("colormake");
        InstallDepends("coreutils");
        InstallDepends("cryptopp");
        InstallDepends("curl");
        InstallDepends("dex2jar");
        InstallDepends("dns2tcp");
        InstallDepends("docbook");
        InstallDepends("docbook-xsl");
        InstallDepends("dpkg");
        InstallDepends("expat");
        InstallDepends("fcrackzip");
        InstallDepends("findutils");
        InstallDepends("fontconfig");
        InstallDepends("foremost");
        InstallDepends("freetype");
        InstallDepends("fribidi");
        InstallDepends("gcc");
        InstallDepends("gdbm");
        InstallDepends("gdk-pixbuf");
        InstallDepends("gettext");
        InstallDepends("git");
        InstallDepends("glib");
        InstallDepends("gmp");
        InstallDepends("gnu-tar");
        InstallDepends("graphite2");
        InstallDepends("gtk-doc");
        InstallDepends("harfbuzz");
        InstallDepends("hashpump");
        InstallDepends("hydra");
        InstallDepends("icu4c");
        InstallDepends("isl");
        InstallDepends("john");
        InstallDepends("jpeg");
        InstallDepends("json-glib");
        InstallDepends("knock");
        InstallDepends("ldid");
        InstallDepends("libdnet");
        InstallDepends("libffi");
        InstallDepends("libimobiledevice");
        InstallDepends("libmpc");
        InstallDepends("libplist");
        InstallDepends("libpng");
        InstallDepends("libssh");
        InstallDepends("libtasn1");
        InstallDepends("libtiff");
        InstallDepends("libtool");
        InstallDepends("libusb");
        InstallDepends("libusbmuxd");
        InstallDepends("libxml2");
        InstallDepends("libzip");
        InstallDepends("lua");
        InstallDepends("lynx");
        InstallDepends("lzo");
        InstallDepends("m4");
        InstallDepends("moreutils");
        InstallDepends("mpfr");
        InstallDepends("mysql-client");
        InstallDepends("nmap");
        InstallDepends("node");
        InstallDepends("openssl@1.1");
        InstallDepends("p7zip");
        InstallDepends("pango");
        InstallDepends("pcre");
        InstallDepends("pcre2");
        InstallDepends("perl");
        InstallDepends("pigz");
        InstallDepends("pixman");
        InstallDepends("pkg-config");
        InstallDepends("pngcheck");
        InstallDepends("python3");
        InstallDepends("readline");
        InstallDepends("screenfetch");
        InstallDepends("socat");
        InstallDepends("source-highlight");
        InstallDepends("sqlite");
        InstallDepends("sqlmap");
        InstallDepends("ssdeep");
        InstallDepends("tcpflow");
        InstallDepends("tcpreplay");
        InstallDepends("tcptrace");
        InstallDepends("ucspi-tcp");
        InstallDepends("xz");
        initFolerAndCD();
        gitCloneRec("https://github.com/tihmstar/libgeneral");
        gitCloneRec("https://github.com/tihmstar/img4tool");
        gitCloneRec("https://github.com/tihmstar/liboffsetfinder64");
        gitCloneRec("https://github.com/BrandonPlank/libipatcher");
        gitCloneRec("https://github.com/tihmstar/libfragmentzip");
        gitCloneRec("https://github.com/libimobiledevice/libirecovery");
        cdAndCompile("libgeneral");
        cdAndCompile("img4tool");
        cdAndCompile("liboffsetfinder64");
        cdAndCompile("libipatcher");
        cdAndCompile("libfragmentzip");
        cdAndCompile("libirecovery");
        printf("Fully installed!\nYou no-longer need to run this script!\n");
        printf("Now to compile any other tool, run\n./autogen.sh\nmake\nsudo make install\n");
    }
    return 0;
}

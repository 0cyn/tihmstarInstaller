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

#define fileExists(file) [[NSFileManager defaultManager] fileExistsAtPath:@(file)]

char *pathToFolder = "~/Desktop/TihmstarSoftware/";

void initInstallBrew(){
    if (fileExists("/usr/local/bin/brew")){
        printf("Skipping brew as it is installed!\n");
        return;
    } else {
        NSString *command = @"cd ";
        command = [command stringByAppendingString:[NSString stringWithFormat:@"/usr/bin/ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\""]];
        system([command UTF8String]);
        return;
    }
}

void InstallDepends(char *name_of_file) {
    if (strcmp(name_of_file, "brew") == 0){
        initInstallBrew();
        return;
    } else {
        NSString *command = @"brew install ";
        command = [command stringByAppendingString:[NSString stringWithFormat:@"%s", name_of_file]];
        system([command UTF8String]);
        printf("Done!\n");
        return;
    }
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

void installiBoot32(){
    if (fileExists("/usr/bin/iBoot32Patcher")){
        printf("Treating iBoot32Patcher with care!\n");
        NSString *command = @"cd ";
        command = [command stringByAppendingString:[NSString stringWithFormat:@"~/Desktop/TihmstarSoftware/iBoot32Patcher; "]];
        printf("Removing old iBoot32Patcher!\n");
        command = [command stringByAppendingString:[NSString stringWithFormat:@"sudo rm -rf /usr/bin/iBoot32Patcher; "]];
        printf("Adding new iBoot32Patcher!\n");
        command = [command stringByAppendingString:[NSString stringWithFormat:@"clang iBoot32Patcher.c finders.c functions.c patchers.c -Wno-multichar -I. -o iBoot32Patcher; "]];
        command = [command stringByAppendingString:[NSString stringWithFormat:@"sudo mv iBoot32Patcher /usr/bin/iBoot32Patcher; "]];
        command = [command stringByAppendingString:[NSString stringWithFormat:@"sudo chmod +x /usr/bin/iBoot32Patcher"]];
        system([command UTF8String]);
        return;
       } else {
           NSString *command = @"cd ";
           command = [command stringByAppendingString:[NSString stringWithFormat:@"~/Desktop/TihmstarSoftware/iBoot32Patcher; "]];
           command = [command stringByAppendingString:[NSString stringWithFormat:@"clang iBoot32Patcher.c finders.c functions.c patchers.c -Wno-multichar -I. -o iBoot32Patcher; "]];
           command = [command stringByAppendingString:[NSString stringWithFormat:@"sudo mv iBoot32Patcher /usr/bin/iBoot32Patcher; "]];
           command = [command stringByAppendingString:[NSString stringWithFormat:@"sudo chmod +x /usr/bin/iBoot32Patcher"]];
           system([command UTF8String]);
           return;
       }
}

void installXpwn(){
    if (fileExists("/usr/local/include/xpwn/libxpwn.h")){
        printf("Skipping xpwn as it is installed!\n");
        return;
    } else {
        NSString *command = @"cd ";
        command = [command stringByAppendingString:[NSString stringWithFormat:@"~/Desktop/TihmstarSoftware/xpwn; "]];
        command = [command stringByAppendingString:[NSString stringWithFormat:@"sh install.sh"]];
        system([command UTF8String]);
        return;
    }
}

void cdAndCompile(char *where){
    if (strcmp(where, "xpwn") == 0){
        installXpwn();
        return;
    } else if (strcmp(where, "iBoot32Patcher") == 0){
        installiBoot32();
        return;
    } else {
        NSString *command = @"cd ";
        command = [command stringByAppendingString:[NSString stringWithFormat:@"~/Desktop/TihmstarSoftware/%s; ", where]];
        command = [command stringByAppendingString:[NSString stringWithFormat:@"export PKG_CONFIG_PATH=\"/usr/local/opt/openssl@1.1/lib/pkgconfig\"; "]];
        command = [command stringByAppendingString:[NSString stringWithFormat:@"./autogen.sh; "]];
        command = [command stringByAppendingString:[NSString stringWithFormat:@"make; "]];
        command = [command stringByAppendingString:[NSString stringWithFormat:@"sudo make install; "]];
        command = [command stringByAppendingString:[NSString stringWithFormat:@"cd ../; "]];
        system([command UTF8String]);
        return;
    }
}

void help(){
    printf("Usage: tihmstarInstaller <arg>\n");
    printf("-c              Just download and compile all the software\n");
    printf("-d              Download all depends\n");
    printf("-a              Do all\n");
    printf("-u              Updates all packages\n");
    printf("-h              Shows this help\n");
    exit(0);
}

void downloadAndCompile(){
    initFolerAndCD();
    //MARK: Download
    gitCloneRec("https://github.com/tihmstar/libgeneral");
    gitCloneRec("https://github.com/tihmstar/img4tool");
    gitCloneRec("https://github.com/tihmstar/liboffsetfinder64");
    gitCloneRec("https://github.com/merculous/xpwn");
    gitCloneRec("https://github.com/tihmstar/libipatcher");
    gitCloneRec("https://github.com/tihmstar/libfragmentzip");
    gitCloneRec("https://github.com/libimobiledevice/libirecovery");
    gitCloneRec("https://github.com/libimobiledevice/libplist");
    gitCloneRec("https://github.com/tihmstar/iBoot64Patcher");
    gitCloneRec("https://github.com/tihmstar/ra1nsn0w");
    gitCloneRec("https://github.com/libimobiledevice/libimobiledevice");
    gitCloneRec("https://github.com/tihmstar/futurerestore");
    gitCloneRec("https://github.com/tihmstar/idevicerestore");
    gitCloneRec("https://github.com/tihmstar/igetnonce");
    gitCloneRec("https://github.com/libimobiledevice/libusbmuxd");
    gitCloneRec("https://github.com/tihmstar/libtakeover");
    gitCloneRec("https://github.com/tihmstar/libgrabkernel");
    gitCloneRec("https://github.com/tihmstar/iBoot32Patcher");
    gitCloneRec("https://github.com/tihmstar/partialZipBrowser");
    //MARK: Compile
    cdAndCompile("libgeneral");
    cdAndCompile("img4tool");
    cdAndCompile("liboffsetfinder64");
    cdAndCompile("xpwn");
    cdAndCompile("libipatcher");
    cdAndCompile("libfragmentzip");
    cdAndCompile("libirecovery");
    cdAndCompile("libplist");
    cdAndCompile("iBoot64Patcher");
    cdAndCompile("ra1nsn0w");
    cdAndCompile("libimobiledevice");
    cdAndCompile("futurerestore");
    cdAndCompile("idevicerestore");
    cdAndCompile("igetnonce");
    cdAndCompile("libusbmuxd");
    cdAndCompile("libtakeover");
    cdAndCompile("libgrabkernel");
    cdAndCompile("iBoot32Patcher");
    cdAndCompile("partialZipBrowser");
    printf("Fully installed!\nYou no-longer need to run this script!\n");
    printf("Now to compile any other tool, run\n./autogen.sh\nmake\nsudo make install\n");
}

void installDep(){
    printf("Installing! Please Wait!\n");
    InstallDepends("brew");
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
}

void removeRepos(){
    NSString *command = @"rm -rf ~/Desktop/TihmstarSoftware/; ";
    command = [command stringByAppendingString:[NSString stringWithFormat:@"mkdir ~/Desktop/TihmstarSoftware/; "]];
    system([command UTF8String]);
    //thanks ethan
}

void update(){
    printf("Updating all software packages!\n");
    initFolerAndCD();
    removeRepos();
    downloadAndCompile();
}

void all(){
    installDep();
    downloadAndCompile();
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        printf("==================================\n");
        printf("tihmstarInstaller by Brandon Plank\n");
        printf("==================================\n\n");
        printf("xpwn install headers script by Merc\n\n");
        if (argc!=2){
            help();
            exit(1);
        }
        NSString *arg1 = [NSString stringWithUTF8String:argv[1]];
        //NSString *arg2 = [NSString stringWithUTF8String:argv[2]];
        if ([arg1  isEqual:@"-c"]){
            downloadAndCompile();
        }
        else if ([arg1 isEqual:@"-a"]){
            all();
        }
        else if ([arg1 isEqual:@"-d"]){
            installDep();
        }
        else if ([arg1 isEqual:@"-u"]){
            update();
        }
        else if ([arg1 isEqual:@"-h"]){
            help();
        }else{
            help();
        }
    }
    return 0;
}

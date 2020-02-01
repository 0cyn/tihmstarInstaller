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

void InstallDepends(char *name_of_file){
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

void gitCloneRec(char *gitaddress, const char *Where){
    NSString *formatted_where = [NSString stringWithUTF8String:Where];
    NSString *command = [NSString stringWithFormat:@"cd %@; git clone --recursive %s", formatted_where, gitaddress];
    
    system([command UTF8String]);
}

void initFolerAndCD(const char *Where){
    NSString *formatted_where = [NSString stringWithUTF8String:Where];
    NSString *command = [NSString stringWithFormat:@"mkdir %@; ", formatted_where];
    command = [command stringByAppendingString:[NSString stringWithFormat:@"cd %@", formatted_where]];
    system([command UTF8String]);
}

void installiBoot32(const char *Where){
    NSString *formatted_where = [NSString stringWithUTF8String:Where];
    if (fileExists("/usr/bin/iBoot32Patcher")){
        printf("Treating iBoot32Patcher with care!\n");
        NSString *command = [NSString stringWithFormat:@" cd %@iBoot32Patcher; sudo rm -rf /usr/bin/iBoot32Patcher; clang iBoot32Patcher.c finders.c functions.c patchers.c -Wno-multichar -I. -o iBoot32Patcher; sudo mv iBoot32Patcher /usr/bin/iBoot32Patcher; sudo chmod +x /usr/bin/iBoot32Patcher", formatted_where];
        system([command UTF8String]);
        return;
       } else {
           NSString *command = [NSString stringWithFormat:@" cd %@iBoot32Patcher; clang iBoot32Patcher.c finders.c functions.c patchers.c -Wno-multichar -I. -o iBoot32Patcher; sudo mv iBoot32Patcher /usr/bin/iBoot32Patcher; sudo chmod +x /usr/bin/iBoot32Patcher", formatted_where];
           system([command UTF8String]);
           return;
       }
}

void installXpwn(const char *Where){
    if (fileExists("/usr/local/include/xpwn/libxpwn.h")){
        NSString *formatted_where = [NSString stringWithUTF8String:Where];
        printf("Treating xpwn with care!\n");
        NSString *command = [NSString stringWithFormat:@"rm -rf /usr/local/include/xpwn; cd %@xpwn; sh install.sh", formatted_where];
        system([command UTF8String]);
        return;
    } else {
        NSString *formatted_where = [NSString stringWithUTF8String:Where];
        NSString *command = [NSString stringWithFormat:@"cd %@xpwn; sh install.sh", formatted_where];
        system([command UTF8String]);
        return;
    }
}

void cdAndCompile(char *where, const char *PathToDir){
    if (strcmp(where, "xpwn") == 0){
        installXpwn(PathToDir);
        return;
    } else if (strcmp(where, "iBoot32Patcher") == 0){
        installiBoot32(PathToDir);
        return;
    } else {
        NSString *formatted_where = [NSString stringWithUTF8String:PathToDir];
        NSString *command = @"cd ";
        command = [command stringByAppendingString:[NSString stringWithFormat:@"%@%s; ", formatted_where, where]];
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
    printf("-d              Download all depends(not recommended, run -a)\n");
    printf("-a              Do all(Only run once, after this run -c or -u)\n");
    printf("-u              Updates all packages\n");
    printf("-h              Shows this help\n");
    printf("Note            When inputting your custom install location, please edit the config file with the path to the folder :)\n");
    printf("Example Command tihmstarInstaller -c\n");
    exit(0);
}

void downloadAndCompile(const char *Where){
    initFolerAndCD(Where);
    //MARK: Download
    gitCloneRec("https://github.com/tihmstar/libgeneral", Where);
    gitCloneRec("https://github.com/tihmstar/img4tool", Where);
    gitCloneRec("https://github.com/tihmstar/liboffsetfinder64", Where);
    gitCloneRec("https://github.com/merculous/xpwn", Where);
    gitCloneRec("https://github.com/tihmstar/libipatcher", Where);
    gitCloneRec("https://github.com/tihmstar/libfragmentzip", Where);
    gitCloneRec("https://github.com/libimobiledevice/libirecovery", Where);
    gitCloneRec("https://github.com/libimobiledevice/libplist", Where);
    gitCloneRec("https://github.com/tihmstar/iBoot64Patcher", Where);
    gitCloneRec("https://github.com/tihmstar/ra1nsn0w", Where);
    gitCloneRec("https://github.com/libimobiledevice/libimobiledevice", Where);
    gitCloneRec("https://github.com/tihmstar/futurerestore", Where);
    gitCloneRec("https://github.com/tihmstar/idevicerestore", Where);
    gitCloneRec("https://github.com/tihmstar/igetnonce", Where);
    gitCloneRec("https://github.com/libimobiledevice/libusbmuxd", Where);
    gitCloneRec("https://github.com/tihmstar/libtakeover", Where);
    gitCloneRec("https://github.com/tihmstar/libgrabkernel", Where);
    gitCloneRec("https://github.com/tihmstar/iBoot32Patcher", Where);
    gitCloneRec("https://github.com/tihmstar/partialZipBrowser", Where);
    //MARK: Compile
    cdAndCompile("libgeneral", Where);
    cdAndCompile("img4tool", Where);
    cdAndCompile("liboffsetfinder64", Where);
    cdAndCompile("xpwn", Where);
    cdAndCompile("libipatcher", Where);
    cdAndCompile("libfragmentzip", Where);
    cdAndCompile("libirecovery", Where);
    cdAndCompile("libplist", Where);
    cdAndCompile("iBoot64Patcher", Where);
    cdAndCompile("ra1nsn0w", Where);
    cdAndCompile("libimobiledevice", Where);
    cdAndCompile("futurerestore", Where);
    cdAndCompile("idevicerestore", Where);
    cdAndCompile("igetnonce", Where);
    cdAndCompile("libusbmuxd", Where);
    cdAndCompile("libtakeover", Where);
    cdAndCompile("libgrabkernel", Where);
    cdAndCompile("iBoot32Patcher", Where);
    cdAndCompile("partialZipBrowser", Where);
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
    InstallDepends("zip");
    InstallDepends("xz");
}

void removeRepos(const char *Where){
    NSString *formatted_where = [NSString stringWithUTF8String:Where];
    NSString *command = [NSString stringWithFormat:@"rm -rf %@; mkdir %@; ", formatted_where, formatted_where];
    system([command UTF8String]);
}

void update(const char *Where){
    printf("Updating all software packages!\n");
    initFolerAndCD(Where);
    removeRepos(Where);
    downloadAndCompile(Where);
}

void all(const char *Where){
    installDep();
    downloadAndCompile(Where);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        printf("==================================\n");
        printf("tihmstarInstaller\n");
        printf("Made by 0x36b\n");
        printf("==================================\n\n");
        
        if (argc!=2) {
            help();
            exit(0);
        }
        
        NSString *arg1 = [NSString stringWithUTF8String:argv[1]];
        //NSString *arg2 = [NSString stringWithUTF8String:argv[2]]; //Custom directory.
        
        // get a reference to our file
        NSString *arg2 = [[NSBundle mainBundle]pathForResource:@"config/config" ofType:@"txt"];
        printf("%s\n", [arg2 UTF8String]);
        // read the contents into a string
        NSString *arg2_1 = [[NSString alloc]initWithContentsOfFile:arg2 encoding:NSUTF8StringEncoding error:nil];
             
        // display our file
        NSLog(@"Our config file contains this: %@\n", arg2_1);
        NSLog(@"debug 1: %@\n", arg1);
        
        arg2_1 = [arg2_1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
        if ([arg2_1 isEqual:@"default"]){
            arg2_1 = [NSString stringWithFormat:@"~/Desktop/TihmstarSoftware/"];
            printf("Did not input custom location, Setting default to ~/Desktop/TihmstarSoftware/\n");
        } else {
            arg2_1 = arg2_1;
            printf("Did find input custom location, Setting default to %s\n", [arg2_1 UTF8String]);
        }
        //exit(1);
        NSString *where = [NSString stringWithFormat:@"%@", arg2_1];
        if ([arg1  isEqual:@"-c"]){
            downloadAndCompile([where UTF8String]);
        }
        else if ([arg1 isEqual:@"-a"]){
            all([where UTF8String]);
        }
        else if ([arg1 isEqual:@"-d"]){
            installDep();
        }
        else if ([arg1 isEqual:@"-u"]){
            update([where UTF8String]);
        }
        else if ([arg1 isEqual:@"-h"]){
            help();
        }else{
        help();
        }
    }
    return 0;
}

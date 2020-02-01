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

void InstallDepends(const char *name_of_file){
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

void cdAndCompile(const char *where, const char *PathToDir){
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

void gitCloneRec(const char *gitaddress, const char *Where){
    NSString *format = [NSString stringWithUTF8String:gitaddress];
    
    NSArray * actualPlace = [format componentsSeparatedByCharactersInSet:
    [NSCharacterSet characterSetWithCharactersInString:@"/"]];
    NSString *lastWord = actualPlace.lastObject;
    printf("%s\n", [lastWord UTF8String]);
    
    NSString *formatted_where = [NSString stringWithUTF8String:Where];
    NSString *command = [NSString stringWithFormat:@"cd %@; git clone --recursive %s", formatted_where, gitaddress];
    
    cdAndCompile([lastWord UTF8String], Where);
    
    system([command UTF8String]);
}

void initFolerAndCD(const char *Where){
    NSString *formatted_where = [NSString stringWithUTF8String:Where];
    NSString *command = [NSString stringWithFormat:@"mkdir %@; ", formatted_where];
    command = [command stringByAppendingString:[NSString stringWithFormat:@"cd %@", formatted_where]];
    system([command UTF8String]);
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
    NSArray *tools;
    int i;
    int count;
       
    tools = [NSArray arrayWithObjects:@"https://github.com/tihmstar/libgeneral", @"https://github.com/tihmstar/img4tool", @"https://github.com/tihmstar/liboffsetfinder64", @"https://github.com/0x36b/xpwn", @"https://github.com/tihmstar/libipatcher", @"https://github.com/tihmstar/libfragmentzip", @"https://github.com/libimobiledevice/libirecovery", @"https://github.com/libimobiledevice/libplist", @"https://github.com/tihmstar/iBoot64Patcher", @"https://github.com/tihmstar/ra1nsn0w", @"https://github.com/libimobiledevice/libimobiledevice", @"https://github.com/tihmstar/futurerestore", @"https://github.com/tihmstar/idevicerestore", @"https://github.com/tihmstar/igetnonce", @"https://github.com/libimobiledevice/libusbmuxd", @"https://github.com/tihmstar/libtakeover", @"https://github.com/tihmstar/libgrabkernel", @"https://github.com/tihmstar/iBoot32Patcher", @"https://github.com/tihmstar/partialZipBrowser", nil];
    count = [tools count];
    for (i = 0; i < count; i++){
        printf("Installing %s...\n", [[tools objectAtIndex:i]UTF8String]);
        gitCloneRec([[tools objectAtIndex:i]UTF8String], Where);
    }
    printf("Fully installed!\nYou no-longer need to run this script!\n");
    printf("Now to compile any other tool, run\n./autogen.sh\nmake\nsudo make install\n");
}

void installDep(){
    printf("Installing! Please Wait!\n");
    NSArray *tools;
    int i;
    int count;
    
    tools = [NSArray arrayWithObjects:@"brew", @"ack", @"atk", @"autoconf", @"automake", @"binutils", @"binwalk", @"boost", @"cairo", @"cifer", @"clutter", @"cmake", @"cogl", @"colormake", @"coreutils", @"cryptopp", @"curl", @"dex2jar", @"dns2tcp", @"docbook", @"docbook-xsl", @"dpkg", @"expat", @"fcrackzip", @"findutils", @"fontconfig", @"foremost", @"freetype", @"fribidi", @"gcc", @"gdbm", @"gdk-pixbuf", @"gettext", @"git", @"glib", @"gmp", @"gnu-tar", @"graphite2", @"gtk-doc", @"harfbuzz", @"hashpump", @"hydra", @"icu4c", @"isl", @"john", @"jpeg", @"json-glib", @"knock", @"ldid", @"libdnet", @"libffi", @"libimobiledevice", @"libmpc", @"libplist", @"libpng", @"libssh", @"libtasn1", @"libtiff", @"libtool", @"libusb", @"libusbmuxd", @"libxml2", @"libzip", @"lua", @"lynx", @"lzo", @"m4", @"moreutils", @"mpfr", @"mysql-client", @"nmap", @"node", @"openssl@1.1", @"p7zip", @"pango", @"pcre", @"pcre2", @"perl", @"pigz", @"pixman", @"pkg-config", @"pngcheck", @"python3", @"readline", @"screenfetch", @"socat", @"source-highlight", @"sqlite", @"sqlmap", @"ssdeep", @"tcpflow", @"tcpreplay", @"tcptrace", @"ucspi-tcp", @"zip", @"xz", nil];
    count = [tools count];
    for (i = 0; i < count; i++){
        printf("Installing %s...\n", [[tools objectAtIndex:i]UTF8String]);
        InstallDepends([[tools objectAtIndex:i]UTF8String]);
    }
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
            if([arg2_1 hasSuffix:@"/"]){
                printf("Please do not use / on the end of your path!\n");
                exit(1);
            }
            printf("Did find input custom location, Setting default to %s\n", [arg2_1 UTF8String]);
            arg2_1 = [arg2_1 stringByAppendingString:[NSString stringWithFormat:@"/"]];
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

morse = struct;
morse.a = '.-';
morse.b = '-...';
morse.c = '-.-.';
morse.d = '-..';
morse.e = '.';
morse.f = '..-.';
morse.g = '--.';
morse.h = '....';
morse.i = '..';
morse.j = '.---';
morse.k = '-.-';
morse.l = '.-..';
morse.m = '--';
morse.n = '-.';
morse.o = '---';
morse.p = '.--.';
morse.q = '--.-';
morse.r = '.-.';
morse.s = '...';
morse.t = '-';
morse.u = '..-';
morse.v = '...-';
morse.w = '.--';
morse.x = '-..-';
morse.y = '-.--';
morse.z = '--..';
morse.n0 = '-----';
morse.n1 = '.----';
morse.n2 = '..---';
morse.n3 = '...--';
morse.n4 = '....-';
morse.n5 = '.....';
morse.n6 = '-....';
morse.n7 = '--...';
morse.n8 = '---..';
morse.n9 = '----.';
morse.sc = '.-,'''; %if input has full stop, dash, comma, quotes
morse.scv = {['.-.-.-'], ['-.-.-.'], ['--..--'], ['-.-.-.-']};

save 'translator.mat' 'morse'
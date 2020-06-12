#!/usr/bin/env perl6
my $data = slurp "data_txt.txt";
my @listTotal = [];
my @listIP = [];
push @listTotal, "$data/";
my $i = 0;
my $IP;
if $i != 1000 {
    for @listTotal.match(/(\d ** { 1 .. 3 }\.\d ** { 1 .. 3 }\.\d ** { 1 .. 3 }\.\d ** { 1 .. 3 })/ ,:g) -> $IP {
    push @listIP, "$IP\n" ; # Cоздали массив со всеми IP адресами из файла
    ++$i;
    }
}
#print @listIP;
#print $i;
my $k = 0;
my %listTopIP = (); # Создали словарь

loop  (my $j = 0; $j < $i ; ++$j) {
    loop (my $k = $j + 1; $k < $i; ++$k) {
        if @listIP[$j] === @listIP[$k] {
            %listTopIP.push: (@listIP[$j] => $j);
            %listTopIP.push: (@listIP[$j] => $k);
            # Поиск повторяющихся IP адресов
        }
    }
}

my %listUniqIP = ();
loop (my $s = 0; $s < %listTopIP.keys.elems; ++$s){
    %listUniqIP.push: (%listTopIP.keys[$s] => %listTopIP.values[$s].unique);
    # Убрали повторяющиеся значнеия из словаря
}

my %listUniqIPvalues = ();
loop (my $s1 = 0; $s1 < %listUniqIP.keys.elems; ++$s1) {
    %listUniqIPvalues.push: (%listUniqIP.keys[$s1] => %listUniqIP.values[$s1].elems);
    # Посчитали количесвто значений в словаре
}

for %listUniqIPvalues.pairs.sort: { $^b.value <=> $^a.value } -> $pair {
    say $pair; # отсортировали словарь по значениям по убыванию
}

#print %listUniqIPvalues.values.sort;
#say %listTopIP.values[];
#say %listTopIP.values;
#say %listTopIP.values.sort;

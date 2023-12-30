$pdf_mode = 1;

# https://tex.stackexchange.com/a/541990
# License: CC BY-SA 4.0 <https://creativecommons.org/licenses/by-sa/4.0/>
add_cus_dep( 'acn', 'acr', 0, 'makeglossaries' );
add_cus_dep( 'glo', 'gls', 0, 'makeglossaries' );
$clean_ext .= " acr acn alg glo gls glg";
sub makeglossaries {
     my ($base_name, $path) = fileparse( $_[0] );
     my @args = ( "-d", $path, $base_name );
     if ($silent) { unshift @args, "-q"; }
     return system "makeglossaries", @args;
}

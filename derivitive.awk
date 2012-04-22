#! /bin/awk -f
BEGIN { firstline = 1 }

$0 !~ /^#/ { if (firstline == 1) {
	old_x = $1
	old_y = $2
	firstline = 0
} else {
print $1 , "\t", (old_y - $2)/(old_x - $1), "\t"
old_x = $1
old_y = $2
}
}

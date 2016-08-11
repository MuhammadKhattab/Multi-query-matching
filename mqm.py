dict_file = open("dict", 'r')
dict = {}

for dict_entry in dict_file:
    ref = dict
    tmp = dict_entry.rstrip('\n').split(' ')
    for i in tmp:
        if i not in ref:
            ref[i]={}
        ref = ref[i]
        if (i == tmp[-1]):
            ref['']=1
# print(dict)

def found_match(fm_print_line, fm_match, fm_found, fm_ref):
	fm_print_line = fm_print_line+"<FOUND>"+fm_match.rstrip(' ')+"<\/FOUND> "
	fm_found =1
	fm_ref = dict
	fm_match =""
	return fm_print_line, fm_match, fm_found, fm_ref

text_file = open("text", 'r')
for line in text_file:
	found =0
	ref = dict
	switch =0
	arr = line.rstrip('\n').split(' ')
	match =""
	print_line = ""
	for i in range(len(arr)):
		tmp = arr[i]
		if (tmp in ref):
			ref = ref[tmp]
			match=match+tmp+' '
			if ('' in ref):
				print_line, match, found, ref = found_match(print_line, match, found, ref)
		else:
			ref = dict
			if (tmp not in ref):
				print_line=print_line+match+tmp+' '
			else:
				print_line=print_line + match
				match =''
				ref = ref[tmp]
				match=tmp+' '
				if ('' in ref):
					print_line, match, found, ref = found_match(print_line, match, found, ref)

	if found ==1:
		print(print_line.rstrip(' '))

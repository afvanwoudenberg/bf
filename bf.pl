% bf.pl
% Aswin van Woudenberg

get_mem(Mem,Value,Ref) :-
	member((Ref,Value),Mem).
get_mem(Mem,0,Ref) :-
	not(member((Ref,_),Mem)).

set_mem(Mem,NewMem,Value,Ref) :-
	member((Ref,_),Mem),
	select((Ref,_),Mem,(Ref,Value),NewMem).
set_mem(Mem,[(Ref,Value)|Mem],Value,Ref) :-
	not(member((Ref,_),Mem)).

inc_mem(Mem,NewMem,Ref) :-
	get_mem(Mem,Value,Ref),
	NewValue is (Value + 1) mod 256,
	set_mem(Mem,NewMem,NewValue,Ref).

dec_mem(Mem,NewMem,Ref) :-
	get_mem(Mem,Value,Ref),
	NewValue is (Value + 255) mod 256,
	set_mem(Mem,NewMem,NewValue,Ref).
	
skip_forward(Prog,Rest) :- 
	skip_forward(Prog,Rest, 0).
skip_forward([']'|Rest],Rest,0).
skip_forward([']'|Rest],NewRest,Num) :-
	Num > 0,
	NewNum is Num - 1,
	skip_forward(Rest,NewRest,NewNum).
skip_forward(['['|Rest],NewRest,Num) :-
	NewNum is Num + 1,
	skip_forward(Rest,NewRest,NewNum).
skip_forward([Inst|Rest],NewRest,Num) :-
	not(member(Inst,['[',']'])),
	skip_forward(Rest,NewRest,Num).

sequence([],_,_,_) :- !.
sequence(Inst,Stack,Mem,Ptr) :-
	instruction(Inst,Stack,Mem,Ptr,NewInst,NewStack,NewMem,NewPtr),
	sequence(NewInst,NewStack,NewMem,NewPtr).

instruction(['>'|Rest],Stack,Mem,Ptr,Rest,Stack,Mem,NewPtr) :-
	NewPtr is Ptr + 1, !.
instruction(['<'|Rest],Stack,Mem,Ptr,Rest,Stack,Mem,NewPtr) :-
	NewPtr is Ptr - 1, !.
instruction(['+'|Rest],Stack,Mem,Ptr,Rest,Stack,NewMem,Ptr) :-
	inc_mem(Mem,NewMem,Ptr), !.
instruction(['-'|Rest],Stack,Mem,Ptr,Rest,Stack,NewMem,Ptr) :-
	dec_mem(Mem,NewMem,Ptr), !.
instruction(['.'|Rest],Stack,Mem,Ptr,Rest,Stack,Mem,Ptr) :-
	get_mem(Mem,Value,Ptr),
	put_code(Value), !.
instruction([','|Rest],Stack,Mem,Ptr,Rest,Stack,NewMem,Ptr) :-
	get_single_char(Value),
	set_mem(Mem,NewMem,Value,Ptr), !.
instruction(['['|Rest],Stack,Mem,Ptr,NewRest,Stack,Mem,Ptr) :-
	get_mem(Mem,0,Ptr),
	skip_forward(Rest,NewRest), !.
instruction(['['|Rest],Stack,Mem,Ptr,Rest,[Rest|Stack],Mem,Ptr) :-
	not(get_mem(Mem,0,Ptr)), !.
instruction([']'|Rest],[_|NewStack],Mem,Ptr,Rest,NewStack,Mem,Ptr) :-
	get_mem(Mem,0,Ptr), !.
instruction([']'|_],[NewRest|Stack],Mem,Ptr,NewRest,[NewRest|Stack],Mem,Ptr) :-
	not(get_mem(Mem,0,Ptr)), !.
instruction([Inst|Rest],Stack,Mem,Ptr,Rest,Stack,Mem,Ptr) :-
	not(member(Inst,['+','-','<','>','.',',','[',']'])).

run(Prog) :-
	sequence(Prog,[],[],0).

load_bf_program(FileName, Prog) :-
	see(FileName),
	get_char(Char),
	process(Char,Prog),
	seen.

process(end_of_file,[]) :- !. 
process(Head,[Head|Tail]) :- 
	get_char(Char),
	process(Char,Tail). 

run_bf_program(FileName) :-
	load_bf_program(FileName,Prog), 
	run(Prog).

run_hello_world :-
	hello_world(Atom),
	atom_chars(Atom,Prog),
	sequence(Prog,[],[],0).

hello_world('++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.').

% load_bf_program('hellobf.bf',Prog), run(Prog).
% run_bf_program('hellobf.bf').

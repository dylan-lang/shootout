module:        list
synopsis:      implementation of "List Processing" benchmark
author:        Peter Hinely
copyright:     public domain


define constant deques = make(<deque>);

define inline function new-deque() => (deque :: <object-deque>);
  (deques.empty? & make(<deque>)) | deques.pop
end;

define inline function save-deques(#rest args)
  for (dq in args) 
    dq.size := 0;
    push(deques, dq);
  end;
end;


define function test-lists (items :: <integer>)
  let L1 = new-deque();
  for (i from 1 to items)
    push-last(L1, i)
  end;

  let L2 = new-deque();
  for (elt in L1)
    push-last(L2, elt);
  end;

  let L3 = new-deque();
  until (L2.empty?)
    push-last(L3, L2.pop);
  end;

  until (L3.empty?)
    push-last(L2, L3.pop-last);
  end;

  L1 := reverse!(L1);

  let result = L1[0] == items
    & every?(method(a :: <integer>, b :: <integer>) a == b end, L1, L2)
    & L1.size;

  save-deques(L1, L2, L3);
  result;
end;


define function main ()
  let iters = string-to-integer(element(application-arguments(), 0, default: "1"));
  let result = #f;
  for (i from 1 to iters)
    result := test-lists(10000)
  end;
  format-out("%=\n", result);
end;


main();

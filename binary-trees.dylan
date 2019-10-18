module: binary-trees

define constant <tree> = false-or(<node>);

define class <node> (<object>)
  constant slot left :: <tree>, required-init-keyword: left:;
  constant slot right :: <tree>, required-init-keyword: right:;
end;

define sealed domain make(singleton(<node>));
define sealed domain initialize(<node>);

define function build(d :: <integer>) => (res :: <tree>)
  if (d == 0)
    #f;
  else
    make(<node>, left: build(d - 1), right: build(d - 1));
  end;
end;

define function check(tree :: <tree>) => (res :: <integer>)
  if (tree) 1 + tree.left.check + tree.right.check else 1 end
end;

begin
  let arg = string-to-integer(element(application-arguments(), 0, default: "10"));
  let min-depth = 4;
  let max-depth = max(min-depth + 2, arg);
  let stretch-depth = max-depth + 1;

  format-out("stretch tree of depth %d\t check: %d\n",
             stretch-depth, build(stretch-depth).check);

  let long-lived-tree = build(max-depth);

  for (d from min-depth to max-depth by 2)
    let iterations = ash(1, max-depth - d + min-depth);
    for (i from 1 to iterations,
         c = 0 then c + build(d).check)
    finally
      format-out("%d\t trees of depth %d\t check: %d\n", iterations, d, c);
    end for;
  end for;

  format-out("long lived tree of depth %d\t check: %d\n",
             max-depth, long-lived-tree.check);
end;

module: binary-trees

define library binary-trees
  use common-dylan;
  use io;
end library;

define module binary-trees
  use common-dylan, exclude: { format-to-string };
  use format;
  use format-out;
  use threads;
end module;

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

  let size = floor/(max-depth - min-depth, 2) + 1;
  let messages = make(<vector>, size: size);
  let threads = make(<vector>, size: size);
  for (i from 0,
       d from min-depth to max-depth by 2)
    let iterations = ash(1, max-depth - d + min-depth);
    local method loop()
            for (_ from 1 to iterations,
                 c = 0 then c + build(d).check)
            finally
              messages[i] := format-to-string("%d\t trees of depth %d\t check: %d", iterations, d, c);
            end for;
          end;
    threads[i] := make(<thread>, function: loop);
  end for;
  for (thread in threads)
    thread & join-thread(thread);
  end;
  for (message in messages)
    format-out("%s\n", message);
  end;

  format-out("long lived tree of depth %d\t check: %d\n",
             max-depth, long-lived-tree.check);
end;

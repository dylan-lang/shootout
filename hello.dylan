module: hello

define library hello
  use io;
end library;

define module hello
  use format-out;
end module;

format-out("hello world\n");
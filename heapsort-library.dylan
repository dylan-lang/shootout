module: dylan-user

define library heapsort
  use common-dylan;
  use io;
end library;

define module heapsort
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;

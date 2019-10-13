module: dylan-user

define library ary
  use common-dylan;
  use io;
end library;

define module ary
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;

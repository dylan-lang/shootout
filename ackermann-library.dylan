module: dylan-user

define library ackermann
  use common-dylan;
  use io;
end library;

define module ackermann
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;

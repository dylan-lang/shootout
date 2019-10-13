module: dylan-user

define library random
  use common-dylan;
  use io;
end library;

define module random
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;

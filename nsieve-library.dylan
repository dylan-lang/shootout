module: dylan-user

define library nsieve
  use common-dylan;
  use io;
end library;

define module nsieve
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;

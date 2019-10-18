module: dylan-user

define library nestedloop
  use common-dylan;
  use io;
end library;

define module nestedloop
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;

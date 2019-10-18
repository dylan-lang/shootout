module: dylan-user

define library strcat
  use common-dylan;
  use io;
end library;

define module strcat
  use common-dylan, exclude: { format-to-string };
  use format-out;
end module;

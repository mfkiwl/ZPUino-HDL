void _premain(void)
{
  volatile int *someRegister=(volatile int *)0;
  volatile int *otherRegister=(volatile int *)4;
  while (*someRegister!=0)
    {
      *otherRegister++;
    }
}

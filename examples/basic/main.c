/* Basic example */

extern int puts(const char *s);
extern char uart_read(void);

int main()
{
  puts("hello, world 1");
  puts("hello, world 2");
  puts("hello, world 3\n");

  puts("Hit key for reboot");
  uart_read();
}






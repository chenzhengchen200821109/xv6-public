# Context switch
#
#   void swtch(struct context **old, struct context *new);
# 
# Save the current registers on the stack, creating
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.
#
# struct context {
#   uint edi;
#   uint esi;
#   uint ebx;
#   uint ebp;
#   uint eip;
# };

.globl swtch
swtch:
  movl 4(%esp), %eax    #指向*old
  movl 8(%esp), %edx    #指向new

  # Save old callee-saved registers
  pushl %ebp
  pushl %ebx
  pushl %esi
  pushl %edi

  # Switch stacks
  movl %esp, (%eax)
  movl %edx, %esp

  # Load new callee-saved registers
  popl %edi
  popl %esi
  popl %ebx
  popl %ebp
  ret

/*
  Computes and displays the Mandelbrot set on the framebuffer. This is
  a modified version of mandel_C.c in Bruno Levy's learn-fpga.
*/

#include <stdio.h>
#include <generated/soc.h>
#include <generated/csr.h>
extern char uart_read();

#define W 600
#define H 600

#define mandel_shift 10
#define mandel_mul (1 << mandel_shift)
#define xmin -2*mandel_mul
#define ymax  2*mandel_mul
#define ymin -2*mandel_mul
#define xmax  2*mandel_mul
#define dx (xmax-xmin)/H
#define dy (ymax-ymin)/H
#define norm_max (4 << mandel_shift)


#define RGB888(R,G,B) ((B) << 16 | (G) << 8 | (R))


uint32_t colormap[21] = {
   RGB888( 0, 0,  0),
   RGB888( 0, 0, 40),
   RGB888( 0, 0, 80),
   RGB888( 0, 0,120),
   RGB888( 0, 0,160),
   RGB888( 0, 0,200),
   RGB888( 0, 0,240),
   
   RGB888( 0,  0, 0),
   RGB888( 0, 40, 0),
   RGB888( 0, 80, 0),
   RGB888( 0,120, 0),
   RGB888( 0,160, 0),
   RGB888( 0,200, 0),
   RGB888( 0,240, 0),

   RGB888(   0, 0, 0),
   RGB888(  40, 0, 0),
   RGB888(  80, 0, 0),
   RGB888( 120, 0, 0),
   RGB888( 160, 0, 0),
   RGB888( 200, 0, 0),
   RGB888( 240, 0, 0)
};

#define FB_BASE 0x40010000
#define FB_WIDTH 800
#define FB_HEIGHT 600

int main() {
  int frame = 0;
  // Config framebuffer DMA
  video_framebuffer_dma_base_write(FB_BASE);
  for(;;) {
    uint32_t *fb = (uint32_t *) (FB_BASE);
    int Ci = ymin;
    for(int Y=0; Y<H; ++Y) {
      int Cr = xmin;
      for(int X=0; X<W; ++X) {
	int Zr = Cr;
	int Zi = Ci;
	int iter = 20;
	while(iter > 0) {
	  int Zrr = (Zr * Zr) >> mandel_shift;
	  int Zii = (Zi * Zi) >> mandel_shift;
	  int Zri = (Zr * Zi) >> (mandel_shift - 1);
	  Zr = Zrr - Zii + Cr;
	  Zi = Zri + Ci;
	  if(Zrr + Zii > norm_max) {
	    break;
	  }
	  --iter;
	}
	int color = (iter+frame)%21;
	*fb++ = colormap[color];
	Cr += dx;
      }
      fb += FB_WIDTH - W;
      Ci += dy;
    }
    frame++;
    puts("Hit key for other frame[any-key-except-R], reboot['R']");
    if (uart_read() == 'R')
      return 0;
  }
}




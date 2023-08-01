---
layout: post
title: Visualization of Hilbert curve in Asymptote
date: 2023-08-01
categories: [math]
tags: [BEM,Asymptote,H-matrix,math-visualization]
mathjax: false
---

I&rsquo;ve written the following Asymptote script which produces Hilbert curve on a 2D grid. Hilbert curve is useful in the sequence partitioning of parallel processing of hierarchical matrices.

```asymptote
unitsize(1mm);

real log2(real x) {static real log2=log(2); return log(x)/log2;}

// Generate a 2D grid
path[] grid2d(real x_spacing, real y_spacing, int x_cell_num, int y_cell_num)
{
  path [] grid;

  for (int i = 0; i < x_cell_num; ++i)
    {
      for (int j = 0; j < y_cell_num; ++j)
        {
          grid = grid^^box((i * x_spacing, j * y_spacing), (i * x_spacing + x_spacing, j * y_spacing + y_spacing));
        }
    }

  return grid;
}

// Draw Hilbert curve for the grid.
// Use 0~3 to represent block types from A to D.
pair draw_hilbert_for_grid(pen mypen, pair previous_segment_end, pair cell_center, real cell_size, int block_type, int max_level, int current_level, int curve_tension)
{
  if (current_level == max_level)
    {
      if (block_type == 0)
        {
          if (previous_segment_end != (0, 0))
            {
              draw(previous_segment_end..tension atleast curve_tension ..cell_center + (-cell_size / 2.0, -cell_size / 2.0)..tension atleast curve_tension ..cell_center + (-cell_size / 2.0, cell_size / 2.0)..tension atleast curve_tension ..cell_center + (cell_size / 2.0, cell_size / 2.0)..tension atleast curve_tension ..cell_center + (cell_size / 2.0, -cell_size / 2.0), p = mypen);
            }
          else
            {
              draw(cell_center + (-cell_size / 2.0, -cell_size / 2.0)..tension atleast curve_tension ..cell_center + (-cell_size / 2.0, cell_size / 2.0)..tension atleast curve_tension ..cell_center + (cell_size / 2.0, cell_size / 2.0)..tension atleast curve_tension ..cell_center + (cell_size / 2.0, -cell_size / 2.0), p = mypen);
            }

          return cell_center + (cell_size / 2.0, -cell_size / 2.0);
        }
      else
        {
          if (block_type == 1)
            {
              if (previous_segment_end != (0, 0))
                {
                  draw(previous_segment_end..tension atleast curve_tension ..cell_center + (-cell_size / 2.0, -cell_size / 2.0)..tension atleast curve_tension ..cell_center + (cell_size / 2.0, -cell_size / 2.0)..tension atleast curve_tension ..cell_center + (cell_size / 2.0, cell_size / 2.0)..tension atleast curve_tension ..cell_center + (-cell_size / 2.0, cell_size / 2.0), p = mypen);
                }
              else
                {
                  draw(cell_center + (-cell_size / 2.0, -cell_size / 2.0)..tension atleast curve_tension ..cell_center + (cell_size / 2.0, -cell_size / 2.0)..tension atleast curve_tension ..cell_center + (cell_size / 2.0, cell_size / 2.0)..tension atleast curve_tension ..cell_center + (-cell_size / 2.0, cell_size / 2.0), p = mypen);
                }

              return cell_center + (-cell_size / 2.0, cell_size / 2.0);
            }
          else
            {
              if (block_type == 2)
                {
                  if (previous_segment_end != (0, 0))
                    {
                      draw(previous_segment_end..tension atleast curve_tension ..cell_center + (cell_size / 2.0, cell_size / 2.0)..tension atleast curve_tension ..cell_center + (-cell_size / 2.0, cell_size / 2.0)..tension atleast curve_tension ..cell_center + (-cell_size / 2.0, -cell_size / 2.0)..tension atleast curve_tension ..cell_center + (cell_size / 2.0, -cell_size / 2.0), p = mypen);
                    }
                  else
                    {
                      draw(cell_center + (cell_size / 2.0, cell_size / 2.0)..tension atleast curve_tension ..cell_center + (-cell_size / 2.0, cell_size / 2.0)..tension atleast curve_tension ..cell_center + (-cell_size / 2.0, -cell_size / 2.0)..tension atleast curve_tension ..cell_center + (cell_size / 2.0, -cell_size / 2.0), p = mypen);
                    }

                  return cell_center + (cell_size / 2.0, -cell_size / 2.0);
                }
              else
                {
                  if (previous_segment_end != (0, 0))
                    {
                      draw(previous_segment_end..tension atleast curve_tension ..cell_center + (cell_size / 2.0, cell_size / 2.0)..tension atleast curve_tension ..cell_center + (cell_size / 2.0, -cell_size / 2.0)..tension atleast curve_tension ..cell_center + (-cell_size / 2.0, -cell_size / 2.0)..tension atleast curve_tension ..cell_center + (-cell_size / 2.0, cell_size / 2.0), p = mypen);
                    }
                  else
                    {
                      draw(cell_center + (cell_size / 2.0, cell_size / 2.0)..tension atleast curve_tension ..cell_center + (cell_size / 2.0, -cell_size / 2.0)..tension atleast curve_tension ..cell_center + (-cell_size / 2.0, -cell_size / 2.0)..tension atleast curve_tension ..cell_center + (-cell_size / 2.0, cell_size / 2.0), p = mypen);
                    }

                  return cell_center + (-cell_size / 2.0, cell_size / 2.0);
                }
            }
        }
    }
  else
    {
      if (block_type == 0)
        {
          previous_segment_end = draw_hilbert_for_grid(mypen, previous_segment_end, cell_center + (-cell_size / 2.0, -cell_size / 2.0), cell_size / 2.0, 1, max_level, current_level + 1, curve_tension);
          previous_segment_end = draw_hilbert_for_grid(mypen, previous_segment_end, cell_center + (-cell_size / 2.0, cell_size / 2.0), cell_size / 2.0, 0, max_level, current_level + 1, curve_tension);
          previous_segment_end = draw_hilbert_for_grid(mypen, previous_segment_end, cell_center + (cell_size / 2.0, cell_size / 2.0), cell_size / 2.0, 0, max_level, current_level + 1, curve_tension);
          previous_segment_end = draw_hilbert_for_grid(mypen, previous_segment_end, cell_center + (cell_size / 2.0, -cell_size / 2.0), cell_size / 2.0, 2, max_level, current_level + 1, curve_tension);
        }
      else
        {
          if (block_type == 1)
            {
              previous_segment_end = draw_hilbert_for_grid(mypen, previous_segment_end, cell_center + (-cell_size / 2.0, -cell_size / 2.0), cell_size / 2.0, 0, max_level, current_level + 1, curve_tension);
              previous_segment_end = draw_hilbert_for_grid(mypen, previous_segment_end, cell_center + (cell_size / 2.0, -cell_size / 2.0), cell_size / 2.0, 1, max_level, current_level + 1, curve_tension);
              previous_segment_end = draw_hilbert_for_grid(mypen, previous_segment_end, cell_center + (cell_size / 2.0, cell_size / 2.0), cell_size / 2.0, 1, max_level, current_level + 1, curve_tension);
              previous_segment_end = draw_hilbert_for_grid(mypen, previous_segment_end, cell_center + (-cell_size / 2.0, cell_size / 2.0), cell_size / 2.0, 3, max_level, current_level + 1, curve_tension);
            }
          else
            {
              if (block_type == 2)
                {
                  previous_segment_end = draw_hilbert_for_grid(mypen, previous_segment_end, cell_center + (cell_size / 2.0, cell_size / 2.0), cell_size / 2.0, 3, max_level, current_level + 1, curve_tension);
                  previous_segment_end = draw_hilbert_for_grid(mypen, previous_segment_end, cell_center + (-cell_size / 2.0, cell_size / 2.0), cell_size / 2.0, 2, max_level, current_level + 1, curve_tension);
                  previous_segment_end = draw_hilbert_for_grid(mypen, previous_segment_end, cell_center + (-cell_size / 2.0, -cell_size / 2.0), cell_size / 2.0, 2, max_level, current_level + 1, curve_tension);
                  previous_segment_end = draw_hilbert_for_grid(mypen, previous_segment_end, cell_center + (cell_size / 2.0, -cell_size / 2.0), cell_size / 2.0, 0, max_level, current_level + 1, curve_tension);
                }
              else
                {
                  previous_segment_end = draw_hilbert_for_grid(mypen, previous_segment_end, cell_center + (cell_size / 2.0, cell_size / 2.0), cell_size / 2.0, 2, max_level, current_level + 1, curve_tension);
                  previous_segment_end = draw_hilbert_for_grid(mypen, previous_segment_end, cell_center + (cell_size / 2.0, -cell_size / 2.0), cell_size / 2.0, 3, max_level, current_level + 1, curve_tension);
                  previous_segment_end = draw_hilbert_for_grid(mypen, previous_segment_end, cell_center + (-cell_size / 2.0, -cell_size / 2.0), cell_size / 2.0, 3, max_level, current_level + 1, curve_tension);
                  previous_segment_end = draw_hilbert_for_grid(mypen, previous_segment_end, cell_center + (-cell_size / 2.0, cell_size / 2.0), cell_size / 2.0, 1, max_level, current_level + 1, curve_tension);
                }
            }
        }

      return previous_segment_end;
    }
}

real grid_length = 400;
pair grid_center = (grid_length / 2.0, grid_length / 2.0);
int x_cell_num = 128;
real cell_size = grid_length / x_cell_num;
real first_level_cell_size = grid_length / 2.0;

draw(grid2d(cell_size, cell_size, x_cell_num, x_cell_num));
pen mypen = rgb(1.0, 0, 0);
draw_hilbert_for_grid(mypen, (0, 0), grid_center, first_level_cell_size, 0, (int)(log2(x_cell_num)), 1, 4);
```

![img](/figures/2023-07-30-hilbert-curve-n=16.jpg "Hilbert curve on 16x16 grid")

![img](/figures/2023-07-30-hilbert-curve-n=32.jpg "Hilbert curve on 32x32 grid")

![img](/figures/2023-07-30-hilbert-curve-n=64.jpg "Hilbert curve on 64x64 grid")

![img](/figures/2023-07-30-hilbert-curve-n=128.jpg "Hilbert curve on 128x128 grid")

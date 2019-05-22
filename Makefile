#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atilegen <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/06/18 19:59:37 by atilegen          #+#    #+#              #
#    Updated: 2018/07/01 14:06:49 by atilegen         ###   ########.fr        #
#                                                                              #
#******************************************************************************#


NAME	= RT
OS		= $(shell uname)

# directories
SRCDIR	= ./src
INCDIR	= ./includes
OBJDIR	= ./obj

# src / obj files
SRC		= main.c \
		ft_key.c				\
		transform_coord.c		\
		ray.c					\
		quadratic_equation.c	\
		color_math.c			\
		intersect.c			\
		def_figure.c			\
		create_win_img.c 	\
		vector_1.c			\
		vector.c			\
		parse5.c				\
		parse_names.c			\
		parse_checks.c        \
 		parse_cam.c           \
    parse_lgt.c           \
		parse_obj.c           \
		parse1.c				\
		color_filters.c      \
 		ua_1.c           	\
    ua.c          		\
		figure_cut.c			\
		rotations.c
		  #$(addprefix fractals/,$(shell ls $(SRCDIR)/fractals | grep -E ".+\.c"))

OBJ		= $(addprefix $(OBJDIR)/,$(SRC:.c=.o))

# compiler
CC		= gcc
CFLAGS	= -Wall -Wextra -Werror -g


# mlx library

MLX		= ./minilibx_macos/
MLX_LNK	= -L $(MLX) -l mlx -framework OpenGL -framework AppKit

MLX_INC	= -I $(MLX)
MLX_LIB	= $(addprefix $(MLX),mlx.a)

# ft library
FT		= ./libft/
FT_LIB	= $(addprefix $(FT),libft.a)
FT_INC	= -I ./libft
FT_LNK	= -L ./libft -l ft -l pthread

all: obj $(FT_LIB) $(MLX_LIB) $(NAME)

obj:
	mkdir -p $(OBJDIR)

$(OBJDIR)/%.o:$(SRCDIR)/%.c
	$(CC) $(CFLAGS) $(MLX_INC) $(FT_INC) -I $(INCDIR) -o $@ -c $<

$(FT_LIB):
	@make -C $(FT)

$(MLX_LIB):
	@make -C $(MLX)

$(NAME): $(OBJ)
	$(CC) $(OBJ) $(MLX_LNK) $(FT_LNK) -lm -o $(NAME)

clean:
	rm -rf $(OBJDIR)
	make -C $(FT) clean
	make -C $(MLX) clean

fclean: clean
	rm -rf $(NAME)
	make -C $(FT) fclean

re: fclean all

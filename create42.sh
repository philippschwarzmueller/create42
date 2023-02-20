$projectname
$libft
$libft_link
echo "Welcome to create-42!"
read -p "Project name: " projectname
read -p "Libft allowed? (y/n) " libft
if [ "$libft" = "y" ]; then
	read -p "Link to libft-repo: " libft_link
fi
mkdir $projectname
git init $projectname/.
if [ "$libft" = "y" ]; then
	echo $libft_link
	cd $projectname
	git submodule add $libft_link
	cd ..
fi
touch $projectname/Makefile
echo "NAME = $projectname" >> $projectname/Makefile
echo "\n# Compiler Settings\n" >> $projectname/Makefile
echo "CC = cc" >> $projectname/Makefile
echo "CFLAGS = -Wall -Werror -Wextra" >> $projectname/Makefile
echo "\n# Source Settings\n" >> $projectname/Makefile
if [ "$libft" = "y" ]; then
	echo "LIBFT = ./libft/libft.a" >> $projectname/Makefile
fi
echo "SRC = " >> $projectname/Makefile
echo "OBJ = \$(SRC:.c=.o)" >> $projectname/Makefile
echo "\n# Rules\n" >> $projectname/Makefile
echo "all: \$(NAME)" >> $projectname/Makefile
if [ "$libft" = "y" ];
then
	echo "\$(NAME): \$(LIBFT) \$(OBJ)" >>  $projectname/Makefile
	echo "	\$(CC) \$(CFLAGS) \$(OBJ) \$(LIBFT) -o \$(NAME)" >> $projectname/Makefile
else
	echo "\$(NAME): \$(OBJ)" >>  $projectname/Makefile
	echo "	\$(CC) \$(CFLAGS) \$(OBJ) -o \$(NAME)" >> $projectname/Makefile
fi
if [ "$libft" = "y" ]; then
	echo "\$(LIBFT):" >> $projectname/Makefile
	echo "	git submodule init" >> $projectname/Makefile
	echo "	git submodule update" >> $projectname/Makefile
	echo "	cd libft && \$(MAKE)" >> $projectname/Makefile
fi
echo "clean:" >> $projectname/Makefile
echo "	rm \$(OBJ)" >> $projectname/Makefile
echo "fclean: clean" >> $projectname/Makefile
echo "	rm \$(NAME)" >> $projectname/Makefile
echo "re: fclean all" >> $projectname/Makefile
echo "\n.PHONY: all clean fclean re" >> $projectname/Makefile


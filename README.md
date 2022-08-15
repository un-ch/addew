Current script generates: <br>
-initial directories structure; <br>
-Makefile; <br>
-gitignore file. <br>
<br>
<br>command:
<br>
<code>./new_project foo_prj_name</code>
<br>result:
<br>
<code>foo_prj_name/</code>
<br>
<code>|__Makefile</code>
<br>
<code>|_.gitignore</code>
<br>
<code>|__build/</code>
<br>
<code>|__include/</code>
<br>
<code>|__src/</code> <br>
<br>
Note, that if you want to have a singe-file project, you should
<br>
comment out the<code>$(OBJECT_FILES)</code>part on the line 21
in the Makefile:
<br>
<code>20  # targets:</code><br>
<code>21  foo_prj_name: $(SRC_DIR)/foo_prj_name.c #$(OBJECT_FILES)
</code>

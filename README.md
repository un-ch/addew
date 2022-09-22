###addew - add new project
#### Current script generates: <br>
<ul>
<li>initial directories structure;</li>
<li>Makefile;</li>
<li>gitignore file.</li>
</ul>

#### Command:
<code>./new_project foo_prj</code>
#### Result:
<code>foo_prj/</code><br>
<code>foo_prj/Makefile</code><br>
<code>foo_prj/.gitignore</code><br>
<code>foo_prj/build/</code><br>
<code>foo_prj/include/</code><br>
<code>foo_prj/src/</code><br>
<code>foo_prj/src/foo_prj</code><br>
<br>
Note, that if you want to have a singe-file project, you should
<br>
comment out the<code>$(OBJECT_FILES)</code>part on the line 21
in the Makefile:
<br>
<code>20  # targets:</code><br>
<code>21  foo_prj_name: $(SRC_DIR)/foo_prj_name.c #$(OBJECT_FILES)
</code>

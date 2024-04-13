GDPC                p                                                                         X   res://.godot/exported/133200997/export-3820a5f953828d288398680db35f2e8f-test_main.scn   �      �      U��w6]a��h\����    X   res://.godot/exported/133200997/export-c729a601eff16f3589adae00ce841208-settings_ui.scn 0      a      �S�:*�ճu:�    ,   res://.godot/global_script_class_cache.cfg  �&             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex       �      �Yz=������������       res://.godot/uid_cache.bin  `*      n       #`�&������X-�       res://Scenes/settings_ui.gd         '      ��"�J�|ulý��    $   res://Scenes/settings_ui.tscn.remap �%      h       c��t}D#S���    $   res://Scenes/test_main.tscn.remap   &      f       �P�G!!��N�I�b       res://Scenes/test_ui.gd �      �      {�M�V�Ƕ�)S       res://globals.gd�            ��d�SwB���(�       res://icon.svg  �&      �      C��=U���^Qu��U3       res://icon.svg.import   �$      �       N5:�E�e��fI&��       res://project.binary�*      ,      $G�Q���8��τ~�    extends Control

@onready var tree = $Tree

func _ready():
	var root = tree.create_item()
	for key in Globals.params.keys():
		var child = tree.create_item(root)
		child.set_text(0, key)
		child.set_text(1, 'Value')
		for subkey in Globals.params[key].keys():
			var subchild = tree.create_item(child)
			subchild.set_text(0, subkey)
			subchild.set_editable(1, true)			
			var value = Globals.params[key][subkey]
			if typeof(value) == TYPE_STRING:
				subchild.set_cell_mode(1, TreeItem.CELL_MODE_STRING)
				subchild.set_text(1, value)
			elif typeof(value) == TYPE_BOOL:
				subchild.set_cell_mode(1, TreeItem.CELL_MODE_CHECK)
				subchild.set_checked(1, value)
			else:
				subchild.set_cell_mode(1, TreeItem.CELL_MODE_STRING)
				subchild.set_text(1, str(value))


func _on_tree_item_edited():
	var root: TreeItem = tree.get_root()
	for i in root.get_child_count():
		var sec = root.get_child(i)
		var secName = sec.get_text(0)
		for j in sec.get_child_count():
			var secProp: TreeItem = sec.get_child(j)
			var propName = secProp.get_text(0)
			var rawPropVal = secProp.get_text(1)
			var propVal = null
			var propCellMode = secProp.get_cell_mode(1)
			if propCellMode == TreeItem.CELL_MODE_CHECK:
				propVal = secProp.is_checked(1)
			elif propCellMode == TreeItem.CELL_MODE_STRING and typeof(Globals.params[secName][propName]) != TYPE_STRING:
				var json = JSON.new()
				var error = json.parse(rawPropVal)
				propVal = json.data
			else:
				propVal = rawPropVal
			Globals.params[secName][propName] = propVal


func _on_save_button_pressed():
	queue_free()


         RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://Scenes/settings_ui.gd ��������      local://PackedScene_ys2mr          PackedScene          	         names "         SettingsUI    z_index    z_as_relative    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    settings_ui    Control    Label    offset_right    offset_bottom    text    Label2    offset_left    offset_top    SaveButton    Button    Tree    columns 
   hide_root    _on_save_button_pressed    pressed    _on_tree_item_edited    item_edited    	   variants          �                          �?                             B     �A      hello      <D     BD     HD    �GD      world      D     �C     0D     �C      Save & Close      �C            node_count             nodes     `   ��������       ����	                                                    	         
                 ����                  	      
                     ����                                                         ����                                                         ����                                           conn_count             conns                                                              node_paths              editable_instances              version             RSRC               RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script    
   Texture2D    res://icon.svg �eaV�Y�      local://PackedScene_u58th 	         PackedScene          	         names "      	   TestMain    Node2D    TextureRect    offset_right    offset_bottom    texture    	   variants             B                node_count             nodes        ��������       ����                      ����                                 conn_count              conns               node_paths              editable_instances              version             RSRC         extends Control

@onready var tree = $Tree

func _ready():
	var root = tree.create_item()
	for key in Globals.params.keys():
		var child = tree.create_item(root)
		child.set_text(0, key)
		child.set_text(1, 'Value')
		for subkey in Globals.params[key].keys():
			var subchild = tree.create_item(child)
			subchild.set_text(0, subkey)
			subchild.set_editable(1, true)
			var value = Globals.params[key][subkey]
			if typeof(value) == TYPE_STRING:
				subchild.set_cell_mode(1, TreeItem.CELL_MODE_STRING)
				subchild.set_text(1, value)
			elif typeof(value) == TYPE_BOOL:
				subchild.set_cell_mode(1, TreeItem.CELL_MODE_CHECK)
				subchild.set_checked(1, value)
			else:
				subchild.set_cell_mode(1, TreeItem.CELL_MODE_STRING)
				subchild.set_text(1, str(value))


func _on_tree_item_edited():
	var root: TreeItem = tree.get_root()
	for i in root.get_child_count():
		var sec = root.get_child(i)
		var secName = sec.get_text(0)
		for j in sec.get_child_count():
			var secProp: TreeItem = sec.get_child(j)
			var propName = secProp.get_text(0)
			var rawPropVal = secProp.get_text(1)
			var propVal = null
			var propCellMode = secProp.get_cell_mode(1)
			if propCellMode == TreeItem.CELL_MODE_CHECK:
				propVal = secProp.is_checked(1)
			elif propCellMode == TreeItem.CELL_MODE_STRING and typeof(Globals.params[secName][propName]) != TYPE_STRING:
				var json = JSON.new()
				var error = json.parse(rawPropVal)
				propVal = json.data
			else:
				propVal = rawPropVal
			Globals.params[secName][propName] = propVal
              extends Node

var params = {
	"sec1": {
		"test": 1,
		"isEnabled": true,
		"quickMode": false,
		"person": "bob",
		"test2": [1, 2, 3],
		"isEnabled2": [true, false],
		"quickMode2": false,
		"person2": ["bob", "bob2"],
		"test3": 1,
		"isEnabled3": true,
		"quickMode3": false,
		"person3": "bob",
	}
}

@onready var settings_ui = preload("res://Scenes/settings_ui.tscn")

func _input(event):
	if event.is_action_pressed("ui_settings_toggle"):
		var nodes = get_tree().get_nodes_in_group("settings_ui")
		if nodes.size() > 0:
			for node in nodes:
				node.queue_free()
		else:
			var node = settings_ui.instantiate()
			add_child(node)
 GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح����mow�*��f�&��Cp�ȑD_��ٮ}�)� C+���UE��tlp�V/<p��ҕ�ig���E�W�����Sթ�� ӗ�A~@2�E�G"���~ ��5tQ#�+�@.ݡ�i۳�3�5�l��^c��=�x�Н&rA��a�lN��TgK㼧�)݉J�N���I�9��R���$`��[���=i�QgK�4c��%�*�D#I-�<�)&a��J�� ���d+�-Ֆ
��Ζ���Ut��(Q�h:�K��xZ�-��b��ٞ%+�]�p�yFV�F'����kd�^���:[Z��/��ʡy�����EJo�񷰼s�ɿ�A���N�O��Y��D��8�c)���TZ6�7m�A��\oE�hZ�{YJ�)u\a{W��>�?�]���+T�<o�{dU�`��5�Hf1�ۗ�j�b�2�,%85�G.�A�J�"���i��e)!	�Z؊U�u�X��j�c�_�r�`֩A�O��X5��F+YNL��A��ƩƗp��ױب���>J�[a|	�J��;�ʴb���F�^�PT�s�)+Xe)qL^wS�`�)%��9�x��bZ��y
Y4�F����$G�$�Rz����[���lu�ie)qN��K�<)�:�,�=�ۼ�R����x��5�'+X�OV�<���F[�g=w[-�A�����v����$+��Ҳ�i����*���	�e͙�Y���:5FM{6�����d)锵Z�*ʹ�v�U+�9�\���������P�e-��Eb)j�y��RwJ�6��Mrd\�pyYJ���t�mMO�'a8�R4��̍ﾒX��R�Vsb|q�id)	�ݛ��GR��$p�����Y��$r�J��^hi�̃�ūu'2+��s�rp�&��U��Pf��+�7�:w��|��EUe�`����$G�C�q�ō&1ŎG�s� Dq�Q�{�p��x���|��S%��<
\�n���9�X�_�y���6]���մ�Ŝt�q�<�RW����A �y��ػ����������p�7�l���?�:������*.ո;i��5�	 Ύ�ș`D*�JZA����V^���%�~������1�#�a'a*�;Qa�y�b��[��'[�"a���H�$��4� ���	j�ô7�xS�@�W�@ ��DF"���X����4g��'4��F�@ ����ܿ� ���e�~�U�T#�x��)vr#�Q��?���2��]i�{8>9^[�� �4�2{�F'&����|���|�.�?��Ȩ"�� 3Tp��93/Dp>ϙ�@�B�\���E��#��YA 7 `�2"���%�c�YM: ��S���"�+ P�9=+D�%�i �3� �G�vs�D ?&"� !�3nEФ��?Q��@D �Z4�]�~D �������6�	q�\.[[7����!��P�=��J��H�*]_��q�s��s��V�=w�� ��9wr��(Z����)'�IH����t�'0��y�luG�9@��UDV�W ��0ݙe)i e��.�� ����<����	�}m֛�������L ,6�  �x����~Tg����&c�U��` ���iڛu����<���?" �-��s[�!}����W�_�J���f����+^*����n�;�SSyp��c��6��e�G���;3Z�A�3�t��i�9b�Pg�����^����t����x��)O��Q�My95�G���;w9�n��$�z[������<w�#�)+��"������" U~}����O��[��|��]q;�lzt�;��Ȱ:��7�������E��*��oh�z���N<_�>���>>��|O�׷_L��/������զ9̳���{���z~����Ŀ?� �.݌��?�N����|��ZgO�o�����9��!�
Ƽ�}S߫˓���:����q�;i��i�]�t� G��Q0�_î!�w��?-��0_�|��nk�S�0l�>=]�e9�G��v��J[=Y9b�3�mE�X�X�-A��fV�2K�jS0"��2!��7��؀�3���3�\�+2�Z`��T	�hI-��N�2���A��M�@�jl����	���5�a�Y�6-o���������x}�}t��Zgs>1)���mQ?����vbZR����m���C��C�{�3o��=}b"/�|���o��?_^�_�+��,���5�U��� 4��]>	@Cl5���w��_$�c��V��sr*5 5��I��9��
�hJV�!�jk�A�=ٞ7���9<T�gť�o�٣����������l��Y�:���}�G�R}Ο����������r!Nϊ�C�;m7�dg����Ez���S%��8��)2Kͪ�6̰�5�/Ӥ�ag�1���,9Pu�]o�Q��{��;�J?<�Yo^_��~��.�>�����]����>߿Y�_�,�U_��o�~��[?n�=��Wg����>���������}y��N�m	n���Kro�䨯rJ���.u�e���-K��䐖��Y�['��N��p������r�Εܪ�x]���j1=^�wʩ4�,���!�&;ج��j�e��EcL���b�_��E�ϕ�u�$�Y��Lj��*���٢Z�y�F��m�p�
�Rw�����,Y�/q��h�M!���,V� �g��Y�J��
.��e�h#�m�d���Y�h�������k�c�q��ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[          [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://2pvkj2d8hngp"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 [remap]

path="res://.godot/exported/133200997/export-c729a601eff16f3589adae00ce841208-settings_ui.scn"
        [remap]

path="res://.godot/exported/133200997/export-3820a5f953828d288398680db35f2e8f-test_main.scn"
          list=Array[Dictionary]([])
     <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
             ���-�	   res://Scenes/settings_ui.tscnׇ��R_�   res://Scenes/test_main.tscn�eaV�Y�   res://icon.svg  ECFG      application/config/name         ld55   application/run/main_scene$         res://Scenes/test_main.tscn    application/config/features(   "         4.2    GL Compatibility       application/config/icon         res://icon.svg     autoload/Globals         *res://globals.gd   "   display/window/size/viewport_width         #   display/window/size/viewport_height            display/window/stretch/mode         canvas_items   input/ui_settings_toggle�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   `   	   key_label             unicode    `      echo          script      #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility    
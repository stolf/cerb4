<b>{'common.operator'|devblocks_translate|capitalize}:</b><br>
<blockquote style="margin:5px;">
	<select name="oper">
		<option value="in">{'search.oper.in_list'|devblocks_translate}</option>
		<option value="not in">{'search.oper.in_list.not'|devblocks_translate}</option>
	</select>
</blockquote>

<b>{'task.source_extension'|devblocks_translate|capitalize}:</b><br>
{foreach from=$sources item=source key=source_id}
<label><input name="sources[]" type="checkbox" value="{$source_id}"><span style="color:rgb(0,120,0);">{$source->getSourceName()}</span></label><br>
{/foreach}


<form action="{devblocks_url}{/devblocks_url}" method="post" id="frmAddOppNote">
<input type="hidden" name="c" value="crm">
<input type="hidden" name="a" value="saveOppNote">
<input type="hidden" name="opp_id" value="{$opp->id}">
<input type="hidden" name="id" value="">

<b>{'crm.opp.tab.notes.add_note'|devblocks_translate}:</b><br>
<textarea name="content" rows="10" cols="65" style="width:98%;height:200px;"></textarea><br>
{if !empty($workers)}
	<label><input type="checkbox" onclick="toggleDiv('addOppNoteNotifyWorkers');"> <b>{'common.notify_workers'|devblocks_translate}</b></label>
	<div id="addOppNoteNotifyWorkers" style="display:none;">
		<select name="notify_worker_ids[]" multiple="multiple" size="8">
			{foreach from=$active_workers item=worker name=notify_workers}
			{if $worker->id == $active_worker->id}{math assign=notify_me_id equation="x-1" x=$smarty.foreach.notify_workers.iteration}{/if}
			<option value="{$worker->id}">{$worker->getName()}</option>
			{/foreach}
		</select><br>
		{'common.tips.multi_select'|devblocks_translate}<br>
		{if !is_null($notify_me_id)}<button type="button" onclick="this.form.notify_worker_ids.options[{$notify_me_id}].selected=true;">{$translate->_('common.me')}</button>{/if} 
	</div>
{/if}
<br>

<button type="submit"><img src="{devblocks_url}c=resource&p=cerberusweb.core&f=images/check.gif{/devblocks_url}" align="top"> {$translate->_('common.save_changes')|capitalize}</button>
<br>
<br>

{* Display Notes *}
{foreach from=$notes item=note}
	{assign var=worker_id value=$note.n_worker_id}
	<div style="border-top:1px dashed rgb(200,200,200);padding:5px;margin-top:5px;margin-bottom:5px;" onmouseover="toggleDiv('delOppNote{$note.n_id}','inline');" onmouseout="toggleDiv('delOppNote{$note.n_id}','none');">
		<b style="color:rgb(0,120,0);">{if isset($workers.$worker_id)}{$workers.$worker_id->getName()}{else}{'common.anonymous'|devblocks_translate}{/if}</b> 
		<span style="font-size:90%;color:rgb(175,175,175);">{$note.n_created|devblocks_date}</span>
		{if $active_worker->is_superuser || $active_worker->id == $worker_id}
			<span style="display:none;padding:2px;" id="delOppNote{$note.n_id}"><a href="javascript:;" onclick="document.getElementById('btnDelOppNote{$note.n_id}').click();" style="font-size:90%;color:rgb(230,0,0);">delete</a></span>
			<button type="button" id="btnDelOppNote{$note.n_id}" style="display:none;visibility:hidden;" onclick="if(confirm('Are you sure you want to delete this note?')){literal}{{/literal}this.form.a.value='deleteOppNote';this.form.id.value='{$note.n_id}';this.form.submit();{literal}}{/literal}"></button>
		{/if}
		<br>
		{$note.n_content|escape|nl2br}
	</div>
{/foreach}

</form>

<table cellpadding="0" cellspacing="0" border="0" width="98%">
	<tr>
		<td align="left" width="0%" nowrap="nowrap" style="padding-right:5px;"><img src="{devblocks_url}c=resource&p=cerberusweb.core&f=images/gear.gif{/devblocks_url}" align="absmiddle"></td>
		<td align="left" width="100%" nowrap="nowrap"><h1>{$translate->_('common.bulk_update')|capitalize}</h1></td>
	</tr>
</table>

<form action="{devblocks_url}{/devblocks_url}" method="POST" id="formBatchUpdate" name="formBatchUpdate">
<input type="hidden" name="c" value="tickets">
<input type="hidden" name="a" value="doBatchUpdate">
<input type="hidden" name="view_id" value="{$view_id}">
<input type="hidden" name="ticket_ids" value="">
<div style="height:400px;overflow:auto;">

<h2>{$translate->_('common.bulk_update.with')|capitalize}:</h2>
<label><input type="radio" name="filter" value="" onclick="toggleDiv('categoryFilterPanelSender','none');toggleDiv('categoryFilterPanelSubject','none');" {if empty($ticket_ids)}checked{/if}> {$translate->_('common.bulk_update.filter.all')}</label> 
<label><input type="radio" name="filter" value="checks" onclick="toggleDiv('categoryFilterPanelSender','none');toggleDiv('categoryFilterPanelSubject','none');" {if !empty($ticket_ids)}checked{/if}> {$translate->_('common.bulk_update.filter.checked')}</label> 
<label><input type="radio" name="filter" value="sender" onclick="toggleDiv('categoryFilterPanelSender','block');toggleDiv('categoryFilterPanelSubject','none');"> Similar senders</label>
<label><input type="radio" name="filter" value="subject" onclick="toggleDiv('categoryFilterPanelSender','none');toggleDiv('categoryFilterPanelSubject','block');"> Similar subjects</label>
<br>
<br>

<div style='display:none;' id='categoryFilterPanelSender'>
<label><b>When sender matches:</b> (one per line, use * for wildcards)</label><br>
<textarea rows='3' cols='45' style='width:95%' name='senders' wrap="off">{foreach from=$unique_senders key=sender item=total name=senders}{$sender}{if !$smarty.foreach.senders.last}{"\n"}{/if}{/foreach}</textarea><br>
<br>
</div>

<div style='display:none;' id='categoryFilterPanelSubject'>
<label><b>When subject matches:</b> (one per line, use * for wildcards)</label><br>
<textarea rows='3' cols='45' style='width:95%' name='subjects' wrap="off">{foreach from=$unique_subjects key=subject item=total name=subjects}{$subject}{if !$smarty.foreach.subjects.last}{"\n"}{/if}{/foreach}</textarea><br>
<br>
</div>

<H2>{$translate->_('common.bulk_update.do')|capitalize}:</H2>
<table cellspacing="0" cellpadding="2" width="100%">
	{if $active_worker->hasPriv('core.ticket.actions.move')}
	<tr>
		<td width="0%" nowrap="nowrap">Move to:</td>
		<td width="100%"><select name="do_move">
			<option value=""></option>
      		<optgroup label="Move to Group">
      		{foreach from=$teams item=team}
      			<option value="t{$team->id}">{$team->name}</option>
      		{/foreach}
      		</optgroup>
      		
      		{foreach from=$team_categories item=categories key=teamId}
      			{assign var=team value=$teams.$teamId}
      			{if !empty($active_worker_memberships.$teamId)}
	      			<optgroup label="{$team->name}">
	      			{foreach from=$categories item=category}
	    				<option value="c{$category->id}">{$category->name}</option>
	    			{/foreach}
	    			</optgroup>
    			{/if}
     		{/foreach}
      	</select></td>
	</tr>
	{/if}
	
	<tr>
		<td width="0%" nowrap="nowrap">Status:</td>
		<td width="100%">
			<select name="do_status">
				<option value=""></option>
				<option value="0">Open</option>
				<option value="3">Waiting</option>
				{if $active_worker->hasPriv('core.ticket.actions.close')}
				<option value="1">Closed</option>
				{/if}
				{if $active_worker->hasPriv('core.ticket.actions.delete')}
				<option value="2">Deleted</option>
				{/if}
			</select>
			<button type="button" onclick="this.form.do_status.selectedIndex = 1;">open</button>
			<button type="button" onclick="this.form.do_status.selectedIndex = 2;">waiting</button>
			{if $active_worker->hasPriv('core.ticket.actions.close')}<button type="button" onclick="this.form.do_status.selectedIndex = 3;">closed</button>{/if}
			{if $active_worker->hasPriv('core.ticket.actions.delete')}<button type="button" onclick="this.form.do_status.selectedIndex = 4;">deleted</button>{/if}
		</td>
	</tr>
	
	{if $active_worker->hasPriv('core.ticket.actions.spam')}
	<tr>
		<td width="0%" nowrap="nowrap">Spam:</td>
		<td width="100%"><select name="do_spam">
			<option value=""></option>
			<option value="1">Report Spam</option>
			<option value="0">Not Spam</option>
		</select>
		<button type="button" onclick="this.form.do_spam.selectedIndex = 1;">spam</button>
		<button type="button" onclick="this.form.do_spam.selectedIndex = 2;">not spam</button>
		</td>
	</tr>
	{/if}
	
	{if $active_worker->hasPriv('core.ticket.actions.assign')}
	<tr>
		<td width="0%" nowrap="nowrap">Next Worker:</td>
		<td width="100%">
			<select name="do_assign">
				<option value=""></option>
				<option value="0">Anybody</option>
				{foreach from=$workers item=worker key=worker_id name=workers}
					{if $worker_id==$active_worker->id}{math assign=next_worker_id_sel equation="x+1" x=$smarty.foreach.workers.iteration}{/if}
					<option value="{$worker_id}">{$worker->getName()}</option>
				{/foreach}
			</select>
	      	{if !empty($next_worker_id_sel)}
	      		<button type="button" onclick="this.form.do_assign.selectedIndex = {$next_worker_id_sel};">me</button>
	      		<button type="button" onclick="this.form.do_assign.selectedIndex = 1;">anybody</button>
	      	{/if}
		</td>
	</tr>
	{/if}
</table>

{include file="file:$core_tpl/internal/custom_fields/bulk/form.tpl" bulk=true}

<br>
</div>

<button type="button" onclick="ajax.saveBatchPanel('{$view_id}');"><img src="{devblocks_url}c=resource&p=cerberusweb.core&f=images/check.gif{/devblocks_url}" align="top"> {$translate->_('common.save_changes')|capitalize}</button>
<button type="button" onclick="genericPanel.hide();"><img src="{devblocks_url}c=resource&p=cerberusweb.core&f=images/delete.gif{/devblocks_url}" align="top"> {$translate->_('common.cancel')|capitalize}</button>
<br>
</form>
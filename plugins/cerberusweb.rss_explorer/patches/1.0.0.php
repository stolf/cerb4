<?php
/***********************************************************************
| Cerberus Helpdesk(tm) developed by WebGroup Media, LLC.
|-----------------------------------------------------------------------
| All source code & content (c) Copyright 2007, WebGroup Media LLC
|   unless specifically noted otherwise.
|
| This source code is released under the Cerberus Public License.
| The latest version of this license can be found here:
| http://www.cerberusweb.com/license.php
|
| By using this software, you acknowledge having read this license
| and agree to be bound thereby.
| ______________________________________________________________________
|	http://www.cerberusweb.com	  http://www.webgroupmedia.com/
***********************************************************************/
/*
 * IMPORTANT LICENSING NOTE from your friends on the Cerberus Helpdesk Team
 * 
 * Sure, it would be so easy to just cheat and edit this file to use the 
 * software without paying for it.  But we trust you anyway.  In fact, we're 
 * writing this software for you! 
 * 
 * Quality software backed by a dedicated team takes money to develop.  We 
 * don't want to be out of the office bagging groceries when you call up 
 * needing a helping hand.  We'd rather spend our free time coding your 
 * feature requests than mowing the neighbors' lawns for rent money. 
 * 
 * We've never believed in encoding our source code out of paranoia over not 
 * getting paid.  We want you to have the full source code and be able to 
 * make the tweaks your organization requires to get more done -- despite 
 * having less of everything than you might need (time, people, money, 
 * energy).  We shouldn't be your bottleneck.
 * 
 * We've been building our expertise with this project since January 2002.  We 
 * promise spending a couple bucks [Euro, Yuan, Rupees, Galactic Credits] to 
 * let us take over your shared e-mail headache is a worthwhile investment.  
 * It will give you a sense of control over your in-box that you probably 
 * haven't had since spammers found you in a game of "E-mail Address 
 * Battleship".  Miss. Miss. You sunk my in-box!
 * 
 * A legitimate license entitles you to support, access to the developer 
 * mailing list, the ability to participate in betas and the warm fuzzy 
 * feeling of feeding a couple obsessed developers who want to help you get 
 * more done than 'the other guy'.
 *
 * - Jeff Standen, Mike Fogg, Brenan Cavish, Darren Sugita, Dan Hildebrandt
 * 		and Joe Geck.
 *   WEBGROUP MEDIA LLC. - Developers of Cerberus Helpdesk
 */
$db = DevblocksPlatform::getDatabaseService();
$datadict = NewDataDictionary($db); /* @var $datadict ADODB_DataDict */ 

$tables = $datadict->MetaTables();
$tables = array_flip($tables);

// ***** Application

// rssexp_feed
if(!isset($tables['rssexp_feed'])) {
	$flds ="
		id I4 DEFAULT 0 NOTNULL PRIMARY,
		name C(255) DEFAULT '' NOTNULL,
		url C(255) DEFAULT '' NOTNULL
	";
	$sql = $datadict->CreateTableSQL('rssexp_feed', $flds);
	$datadict->ExecuteSQLArray($sql);
}

$columns = $datadict->MetaColumns('rssexp_feed');
$indexes = $datadict->MetaIndexes('rssexp_feed',false);

// rssexp_item
if(!isset($tables['rssexp_item'])) {
	$flds ="
		id I4 DEFAULT 0 NOTNULL PRIMARY,
		feed_id I4 DEFAULT 0 NOTNULL,
		title C(255) DEFAULT '' NOTNULL,
		url C(255) DEFAULT '' NOTNULL,
		created_date I4 DEFAULT 0 NOTNULL,
		is_read I1 DEFAULT 0 NOTNULL
	";
	$sql = $datadict->CreateTableSQL('rssexp_item', $flds);
	$datadict->ExecuteSQLArray($sql);
}

$columns = $datadict->MetaColumns('rssexp_item');
$indexes = $datadict->MetaIndexes('rssexp_item',false);

if(!isset($indexes['feed_id'])) {
    $sql = $datadict->CreateIndexSQL('feed_id','rssexp_item','feed_id');
    $datadict->ExecuteSQLArray($sql);
}

if(!isset($indexes['created_date'])) {
    $sql = $datadict->CreateIndexSQL('created_date','rssexp_item','created_date');
    $datadict->ExecuteSQLArray($sql);
}

if(!isset($indexes['is_read'])) {
    $sql = $datadict->CreateIndexSQL('is_read','rssexp_item','is_read');
    $datadict->ExecuteSQLArray($sql);
}

?>
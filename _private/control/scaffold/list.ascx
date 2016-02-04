﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="list.ascx.cs" Inherits="Sdx.WebLib.Control.Scaffold.List" %>

<div><%= scaffold.Title %>リスト</div>
<ul>
<% foreach(Sdx.Db.Record record in scaffold.RecordSet){ %>
   <li>
     <% foreach(var data in scaffold.DisplayList){ %>
     <div>
        <%= record.GetString(data["column"]) %>
     </div>
     <% } %>
     <div>
       <a href="<%=scaffold.EditPage.Build(new Dictionary<string, string> { {"id", record.GetString("id")} })%>">編集</a>
     </div>
   </li>
<% } %>
</ul>
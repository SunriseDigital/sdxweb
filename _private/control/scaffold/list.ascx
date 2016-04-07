﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="list.ascx.cs" Inherits="Sdx.WebLib.Control.Scaffold.List" %>

<div class="sdx-scaffold-list">
  <%if (groupSelector != null){ %>
  <div class="form-group">
    <%=groupSelector.Tag.Render(Sdx.Html.Attr.Create().AddClass("form-control group-selector")) %>
  </div>
  <%} %>
  <<%=TitleTag %>><%if(scaffold.Group != null && scaffold.Group.TargetValue != null){ %><%=scaffold.Group.Name %> <%} %><%= scaffold.Title %><%=Sdx.I18n.GetString("リスト") %></<%=TitleTag %>>
  
  <form action="<%=Request.Url.PathAndQuery %>" method="post">
    <div class="form-group">
      <a class="btn btn-primary" href="<%=scaffold.EditPageUrl.Build() %>"><%=Sdx.I18n.GetString("新規追加") %></a>
    </div>
    <%if(!scaffold.SortingOrder.IsEmpty){ %>
      <div class="form-group text-right">
        <input class="btn btn-success" type="submit" name="submit_sorting_order" value=<%="\"" + Sdx.I18n.GetString("並び順を保存") + "\"" %> />
      </div>
    <%} %>
    <ul class="resplist resplist-striped">
    <% foreach(Sdx.Db.Record record in recordSet){ %>
      <li class="resplist-row list-row">
        <div class="resplist-items">
          <% foreach(var item in scaffold.DisplayList){ %>
          <div class="resplist-item">
            <div class="resplist-label"<%if (item.ContainsKey("style")){ %> style="<%= item["style"] %>"<%;} %>><%= item["label"] %></div>
            <div class="resplist-value"><%= item.Display(record, conn) %></div>
          </div>
          <% } %>
        </div>
        <div class="resplist-footer clearfix">
          <div class="pull-right">
            <a class="btn btn-primary" href="<%=scaffold.EditPageUrl.Build(new Dictionary<string, string> { {"id", record.GetString("id")} })%>"><%=Sdx.I18n.GetString("編集") %></a>
            <%if(!scaffold.SortingOrder.IsEmpty){ %>
            <div class="btn-group">
              <button class="btn btn-default sort up" data-sort-type="top"><i class="fa fa-step-backward fa-rotate-90"></i></button>
              <button class="btn btn-default sort up" data-sort-type="up"><i class="fa fa-chevron-up"></i></button>
              <button class="btn btn-default sort down" data-sort-type="down"><i class="fa fa-chevron-down"></i></button>
              <button class="btn btn-default sort down" data-sort-type="bottom"><i class="fa fa-step-backward fa-rotate-270"></i></button>
            </div>
            <%} %>
            <button class="btn btn-danger delete"><i class="fa fa-times"></i></button>
          </div>
        </div>
        <input type="hidden" name="pkeys" value="<%= HttpUtility.HtmlEncode(Sdx.Util.Json.Encoder(record.GetPkeyValues()))%>" />
      </li>
    <% } %>
    </ul>
    <%if(!scaffold.SortingOrder.IsEmpty){ %>
      <div class="form-group text-right">
        <input class="btn btn-success" type="submit" name="submit_sorting_order" value=<%="\"" + Sdx.I18n.GetString("並び順を保存") + "\"" %> />
      </div>
    <%} %>
    <%if(pagerLink != null){ %>
    <div class="row">
      <div class="text-center">
        <%= pagerLink.GetFisrt().AddText("<i class=\"fa fa-step-backward\"></i>", false).Render(a => a.AddClass("btn", "btn-default")) %>
        <%= pagerLink.GetPrev().AddText("<i class=\"fa fa-chevron-left\"></i>", false).Render(a => a.AddClass("btn", "btn-default")) %>
        <span class="page-number">
          <%=pagerLink.Pager.Page %>&nbsp;/&nbsp;<%=pagerLink.Pager.LastPage %>
        </span>
        <%= pagerLink.GetNext().AddText("<i class=\"fa fa-chevron-right\"></i>", false).Render(a => a.AddClass("btn", "btn-default")) %>
        <%= pagerLink.GetLast().AddText("<i class=\"fa fa-step-forward\"></i>", false).Render(a => a.AddClass("btn", "btn-default")) %>
      </div>
    </div>
    <%} %>
  </form>
</div>

<input type="hidden" name="DeleteMessage" value=<%="\"" + Sdx.I18n.GetString("削除します。よろしいですか？") + "\"" %>>
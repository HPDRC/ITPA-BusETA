<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="showLog.aspx.cs" Inherits="BusEta.showLog" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <asp:Table ID="logList" runat="server" Width="100%" BorderStyle="Solid" GridLines="Both"> 
        <asp:TableRow>
            <asp:TableCell>Id</asp:TableCell>
            <asp:TableCell>BusId</asp:TableCell>
            <asp:TableCell>Message</asp:TableCell>
            <asp:TableCell>BusTime</asp:TableCell>
            <asp:TableCell>ServerTime</asp:TableCell>
        </asp:TableRow>
    </asp:Table>  
</body>
</html>

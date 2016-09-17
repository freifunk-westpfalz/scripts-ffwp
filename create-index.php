#!/usr/bin/php
<?php
    /**
     * create directory listing to replace webservers listing
     *
     * Usage: ./create-index.php /path/to/directory > /path/to/index.html
     *
     * This file was created to create a non-truncated directory listing for
     * firmware download at Freifunk Westpfalz. Fixes problems with truncated
     * file names in listing, like most webservers do to save space. Also
     * includes some CSS for nicer view. Colours should match official Freifunk
     * colours, see <https://wiki.freifunk.net/Freifunk-Styles>
     * Also checks if there's a md5.txt in directory, and tries to validate
     * md5 hashes of files. If md5 hashes do not match, displays a warning next
     * to file link.
     *
     * @author Felix Kunsmann <felix@kunsmann.eu>
     * @license Creative Commons BY-NC-SA
     */
    
    date_default_timezone_set('Europe/Berlin');
    setlocale(LC_ALL, 'de_DE');
    
    function byte_format($byte) {
        $units = array(
            "B",
            "KB",
            "MB",
            "GB",
            "TB",
            "PB",
            "EB",
            "ZB",
            "YB"
        );
    
        $i = 0;
    
        while ($byte > 1024) {
            $byte /= 1024;
            $i += 1;
        }
    
        $byte = round($byte, 2);
    
        return number_format($byte, 2, ',', ' ') . " " . $units[$i];
    }
    
    function get_md5($path, $file) {
        if (!file_exists($path.'md5.txt')) {
            return '';
        }
        
        $md5s = file($path.'md5.txt');
        
        foreach ($md5s as $line) {
            $c = explode(' ', $line, 2);
            
            if (trim($c[1]) == $file) {
                return trim($c[0]);
            }
        }
        
        return '';
    }
    
    if (!empty($_SERVER['argv'][1])) {
        $dir = realpath($_SERVER['argv'][1]);
    } else {
        $dir = dirname(__FILE__);
    }

    if (substr($dir, -1, 1) != '/') {
        $dir .= '/';
    }

?><!DOCTYPE HTML>
<html>
    <head>
        <title>Index</title>
        <style type="text/css">
            body {
                background-color: #FFFFFF;
            }

            h1 {
                margin-bottom: 20px;
                font-size: 36px;
                text-align: center;
            }

            a:link, a:visited {
                text-decoration: none;
                color: #dc0067;
            }

            a:hover, a:focus {
                text-decoration: underline;
                color: #009ee0;
            }

            table {
                margin: 12px auto;
                width: 95%;
                border: 1px solid #CCCCCC;
                border-collapse: collapse;
            }
            
            tr:hover{
                background-color: #EEEEEE;
            }

            th, td {
                text-align: left;
                border: 1px solid #CCCCCC;
                padding: 5px;
            }

            th {
                font-weight: bold;
            }

            .size {
                text-align: right;
            }
            
            .md5{
                text-transform: uppercase;
                font-family: "Courier New", Courier, monospace;
            }

            div#footer {
                color: #444444;
                padding-top: 25px;
                text-align: center;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    </head>
    <body>
        <h1>Index</h1>
        <table>
            <colgroup>
                <col style="width:45%">
                <col style="width:20%">
                <col style="width:35%">
            </colgroup>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Size</th>
                    <th>MD5</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><a href="../">../</a></td>
                    <td class="size"></td>
                    <td>-</td>
                </tr>
<?php
    foreach (scandir($dir) as $file) {
        if (is_file($dir.$file)) {
            $md5_txt  = get_md5($dir, $file);
            $md5_file = md5_file($dir.$file);
?>
                <tr>
                    <td><a href="<?php echo urlencode($file); ?>"><?php echo htmlspecialchars($file); ?></a><?php if (!empty($md5_txt) && $md5_file != $md5_txt) { ?><br>MD5 hash of file (<span 
class="md5"><?php echo $md5_file; ?></span>) differs from md5.txt (<span class="md5"><?php echo $md5_txt; ?></span>)<?php } ?></td>
                    <td class="size"><?php
            $byte = filesize($dir.$file);

            if ($byte != false) {
                echo byte_format($byte);
            } else {
                echo '-';
            } ?></td>
                    <td class="md5"><?php echo $md5_file; ?></td>
                </tr>
<?php
        }
    }
?>
            </tbody>
        </table>
        <div id="footer"><a href="http://westpfalz.freifunk.net/">Freifunk Westpfalz</a> &bull; Script by Felix 'kunsi' Kunsmann &bull; <a 
href="https://gist.github.com/Kunsi/1187741dbfb1f0228f9a3f8e0e4284b2">Code available at Github Gist</a></div>
    </body>
</html>

// HelpTool
// This macro demonstrates how to create a tool that performs
// an action when you click on its icon in the tool bar.
// The tool, which has a "?" icon, opens the ImageJ website
// when you click on it.


    // This macro defines the "?" tool but it is never called 
    // because the "?" tool cannot be selected.
    macro "Help Tool - C059T3e16?" {
    }

    // Displays the "About ImageJ" window when
    // when user clicks on the "?" tool bar icon.
    macro "Help Tool Selected" {
        restorePreviousTool();
        run("ImageJ Web Site...");
    }

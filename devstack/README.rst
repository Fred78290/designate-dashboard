=================================
Designate dashboard devstack plugin
=================================

This directory contains the designate-dashboard devstack plugin.

To enable the plugin, add the following to your local.conf:

    enable_plugin designate-dashboard <designate-dashboard GITURL> [GITREF]

where

    <designate-dashboard GITURL> is the URL of a designate-dashboard repository
    [GITREF] is an optional git ref (branch/ref/tag). The default is master.

For example:

    enable_plugin designate-dashboard https://opendev.org/openstack/designate-dashboard

Once you enable the plugin in your local.conf, ensure ``horizon`` and
``designate`` services are enabled. If both of them are enabled,
designate-dashboard will be enabled automatically

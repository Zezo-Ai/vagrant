# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: BUSL-1.1

require "vagrant"

module VagrantPlugins
  module ProviderVirtualBox
    class Plugin < Vagrant.plugin("2")
      name "VirtualBox provider"
      description <<-EOF
      The VirtualBox provider allows Vagrant to manage and control
      VirtualBox-based virtual machines.
      EOF

      provider(:virtualbox, priority: 6) do
        require File.expand_path("../provider", __FILE__)
        Provider
      end

      config(:virtualbox, :provider) do
        require File.expand_path("../config", __FILE__)
        Config
      end

      synced_folder(:virtualbox) do
        require File.expand_path("../synced_folder", __FILE__)
        SyncedFolder
      end

      provider_capability(:virtualbox, :forwarded_ports) do
        require_relative "cap"
        Cap
      end

      provider_capability(:virtualbox, :nic_mac_addresses) do
        require_relative "cap"
        Cap
      end

      provider_capability(:virtualbox, :public_address) do
        require_relative "cap/public_address"
        Cap::PublicAddress
      end

      provider_capability(:virtualbox, :configure_disks) do
        require_relative "cap/configure_disks"
        Cap::ConfigureDisks
      end

      provider_capability(:virtualbox, :cleanup_disks) do
        require_relative "cap/cleanup_disks"
        Cap::CleanupDisks
      end

      provider_capability(:virtualbox, :validate_disk_ext) do
        require_relative "cap/validate_disk_ext"
        Cap::ValidateDiskExt
      end

      provider_capability(:virtualbox, :default_disk_exts) do
        require_relative "cap/validate_disk_ext"
        Cap::ValidateDiskExt
      end

      provider_capability(:virtualbox, :set_default_disk_ext) do
        require_relative "cap/validate_disk_ext"
        Cap::ValidateDiskExt
      end

      provider_capability(:virtualbox, :snapshot_list) do
        require_relative "cap"
        Cap
      end

      synced_folder_capability(:virtualbox, "mount_options") do
        require_relative "cap/mount_options"
        Cap::MountOptions
      end

      synced_folder_capability(:virtualbox, "mount_type") do
        require_relative "cap/mount_options"
        Cap::MountOptions
      end

      synced_folder_capability(:virtualbox, "mount_name") do
        require_relative "cap/mount_options"
        Cap::MountOptions
      end
    end

    autoload :Action, File.expand_path("../action", __FILE__)

    # Drop some autoloads in here to optimize the performance of loading
    # our drivers only when they are needed.
    module Driver
      autoload :Meta, File.expand_path("../driver/meta", __FILE__)
      autoload :Version_4_0, File.expand_path("../driver/version_4_0", __FILE__)
      autoload :Version_4_1, File.expand_path("../driver/version_4_1", __FILE__)
      autoload :Version_4_2, File.expand_path("../driver/version_4_2", __FILE__)
      autoload :Version_4_3, File.expand_path("../driver/version_4_3", __FILE__)
      autoload :Version_5_0, File.expand_path("../driver/version_5_0", __FILE__)
      autoload :Version_5_1, File.expand_path("../driver/version_5_1", __FILE__)
      autoload :Version_5_2, File.expand_path("../driver/version_5_2", __FILE__)
      autoload :Version_6_0, File.expand_path("../driver/version_6_0", __FILE__)
      autoload :Version_6_1, File.expand_path("../driver/version_6_1", __FILE__)
      autoload :Version_7_0, File.expand_path("../driver/version_7_0", __FILE__)
      autoload :Version_7_1, File.expand_path("../driver/version_7_1", __FILE__)
    end

    module Model
      autoload :ForwardedPort, File.expand_path("../model/forwarded_port", __FILE__)
      autoload :StorageController, File.expand_path("../model/storage_controller", __FILE__)
      autoload :StorageControllerArray, File.expand_path("../model/storage_controller_array", __FILE__)
    end

    module Util
      autoload :CompileForwardedPorts, File.expand_path("../util/compile_forwarded_ports", __FILE__)
    end
  end
end

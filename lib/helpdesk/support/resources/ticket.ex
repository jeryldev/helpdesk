defmodule Helpdesk.Support.Resources.Ticket do
  # Turns this module into a resource
  use Ash.Resource,
    # Add ETS data layer for testing and prototyping
    data_layer: Ash.DataLayer.Ets

  actions do
    # Add a set of simple actions. You'll customeze these later.
    defaults [:create, :read, :update, :destroy]

    create :open do
      # By default you can provide all public attributes to an action
      # This action should only accept the subject
      accept [:subject]
    end

    update :close do
      # We don't want to accept any input here
      accept []

      change set_attribute(:status, :closed)
      # A custom change could be added like so:
      #
      # change MyCustomChange
      # change {MyCustomChange, opt: :val}
    end
  end

  # Attributes are the simple pieces of data that exist on your resource
  attributes do
    # Add an autogenerated UUID primary key called `:id`.
    uuid_primary_key :id

    # Add a string type attribute called `:subject`
    attribute :subject, :string do
      # Don't allow `nil` values
      allow_nil? false
    end

    # status is either `open` or `closed`. We can add more statuses later
    attribute :status, :atom do
      # Constraints allow you to provide exxtra rules for the value.
      # The available constraints depend on the type
      # See the documentation for each type to know what constraints are available
      # Since atoms are generally only used when we know all of the values
      # it provides a `one_of` constraint, that only allows those values
      constraints one_of: [:open, :closed]

      # Thes status defaulting to open makes sense
      default :open

      # We also don't want status to eer be `nil`
      allow_nil? false
    end
  end
end

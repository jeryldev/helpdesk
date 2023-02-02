defmodule Helpdesk.Support.Representative do
  # This turns this module into a resource using the in memory ETS data layer
  use Ash.Resource,
    # data_layer: Ash.DataLayer.Ets
    data_layer: AshPostgres.DataLayer

  postgres do
    table "representatives"

    repo Helpdesk.Repo
  end

  actions do
    # Add the default simple actions
    defaults [:create, :read, :update, :destroy]
  end

  # Attributes are the simple pieces of data that exist on your resource
  attributes do
    # Add an autogenerated UUID primary key called `:id`.
    uuid_primary_key :id

    # Add a string type attribute called `:name`
    attribute :name, :string
  end

  relationships do
    # `has_many` means that the destination attribute is not unique, therefore many related records
    # We assume that the destination attribute is `representative_id` based
    # on the module name of this resource and that the source attribute is `id`.
    has_many :tickets, Helpdesk.Support.Ticket
  end
end

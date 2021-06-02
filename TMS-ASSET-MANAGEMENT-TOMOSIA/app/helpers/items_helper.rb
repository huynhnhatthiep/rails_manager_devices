module ItemsHelper
    def dataItemNotUsed
        @items_not_used = Item.where(status: 0)
    end
end

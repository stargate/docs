const resolvers = {

  Book: {
    orders(book) {
      return orders.filter(({ books }) => books.includes(book.title));
    }
  },
  Order: {
    book(order) {
      return order.book.map(title => ({ __typename: "Book", title }));
    }
  },
  Query: {
    order(_, args) {
      return orders.find(order => order.checkout_id == args.checkout_id);
    },
    orders() {
      return orders;
    }
  }
};

CREATE TABLE IF NOT EXISTS public.readers
(
    id          serial primary key,
    card_number varchar(10),
    fio         varchar(255),
    address     varchar(255),
    phone       varchar(12)
);


CREATE TABLE IF NOT EXISTS public.authors
(
    id   serial primary key,
    name varchar(255)
);


CREATE TABLE IF NOT EXISTS public.books
(
    id        serial primary key,
    author_id bigint,
    name      varchar(100),
    CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES authors (id)
);

CREATE TABLE IF NOT EXISTS public.publishing_houses
(
    id   serial primary key,
    name varchar(100),
    city varchar(100)
);

CREATE TABLE IF NOT EXISTS public.published_books
(
    id      serial primary key,
    book_id bigint,
    ph_id   bigint,
    volume  int,
    price   numeric,
    count   int,
    CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES books (id),
    CONSTRAINT fk_ph FOREIGN KEY (ph_id) REFERENCES publishing_houses (id)
);

CREATE TABLE IF NOT EXISTS public.books_exemplars
(
    id        serial primary key,
    pb_id     bigint,
    book_code varchar(20),
    CONSTRAINT fk_pb FOREIGN KEY (pb_id) REFERENCES published_books (id)
);

CREATE TABLE IF NOT EXISTS public.issued_books
(
    id         serial primary key,
    reader_id  bigint,
    book_id    bigint,
    issue_date timestamp,
    CONSTRAINT fk_reader FOREIGN KEY (reader_id) REFERENCES readers (id),
    CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES books_exemplars (id)
);

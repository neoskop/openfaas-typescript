export default async (event: any, context: any, _cb: any) => {
  const result = {
    body: JSON.stringify(event.body),
    "content-type": event.headers["content-type"],
  };

  return context.status(200).succeed(result);
};

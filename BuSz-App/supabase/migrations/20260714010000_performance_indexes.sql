-- Add performance indexes for Sprint 3.3
CREATE INDEX IF NOT EXISTS trips_routeId_idx ON "public"."trips"("routeId");
CREATE INDEX IF NOT EXISTS trips_busAgentId_idx ON "public"."trips"("busAgentId");

CREATE INDEX IF NOT EXISTS TripSchedule_departureTime_idx ON "public"."TripSchedule"("departureTime");
CREATE INDEX IF NOT EXISTS TripSchedule_tripId_idx ON "public"."TripSchedule"("tripId");

CREATE INDEX IF NOT EXISTS promotions_isActive_createdAt_idx ON "public"."promotions"("isActive", "createdAt" DESC);
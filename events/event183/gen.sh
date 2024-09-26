lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 33.12820820820821 --fixed-mass2 63.55215215215215 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1008047676.6563425 \
--gps-end-time 1008054876.6563425 \
--d-distr volume \
--min-distance 5639.533419289785e3 --max-distance 5639.553419289786e3 \
--l-distr fixed --longitude -86.32122802734375 --latitude -46.23236846923828 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
